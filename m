Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-02.ptn.no (pt20-qms-02.ptn.no [64.28.25.139])
	by ozlabs.org (Postfix) with SMTP id 1D49D2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 22:02:40 +1100 (EST)
To: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
Message-ID: <OF0D2E3A9D.EF4417D9-ONC1256F4E.00376B14-C1256F4E.003CA8F8@axxessit.no>
From: morten.banzon@axxessit.no
Date: Tue, 16 Nov 2004 12:02:34 +0100
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek <dan@embeddededge.com>
16.11.2004 01:18

 
        To:     morten.banzon@axxessit.no
        cc:     linuxppc-embedded@ozlabs.org
        Subject:        Re: MPC82xx -- DPRAM1



On Nov 15, 2004, at 11:10 AM, morten.banzon@axxessit.no wrote:

>> I am using 2.6.9 for a mpc8280 project, and am having trouble using 
>> dpram1
>> from offset zero, which I need for a mcc hdlc driver.

>Why does it have to start at zero?

When using the mccs the use of dpram1 addresses is determined by the
channel number one choose for the mcc channels. The freedom of choosing
channel numbers are somewhat limited by the mcc hardware. In short if
one have a lot of superchannels, i.e. channels with more than one
time time slot, then legal channel numbers are consumed rapidly.

In my case, I have got 48 super channels, 32 consisting of 3 time slots
and 16 consisting of 9 timeslots, spread over four tdm lines and the two
mccs. In case of mcc1 the first super channel is given the number 0,
hence the need to start at dpram1 address zero. There might be room in
my channel map to increase the lowest channel numbers to get above the
128 first bytes of the dpram1, but I think I just run into trouble
elsewhere.

>>  In the file include/asm-ppc/cpm2.h there is a constant 
>> CPM_DATAONLY_BASE
>> In the same file the code comment say that the first 128 bytes are used
>> for SMC1 and SMC2.

>Yes, it is.
Do you know what these bytes are used for ? As far as I understand it is
not buffer descriptors and not the buffers. Besides these two things I
do not know of anything related to smc that could be put in the dpram1.
Obviously there is something I miss here, and thats the reason for
asking the question in the first place.

>> When I examine the smc (cpm_uart) driver i do not find any reference to
>> this region of the dpram1.

>It's there somewhere, hardcoded with values 0, then sizeof() something 
>is
>probably added to it.
Well, I do not find this piece of code. The buffer descriptors are
allocated with cpm_dpalloc in cpm_uart_allocbuf (cpm_uart_cpm2.c), the
buffers are allocated with alloc_bootmem. The first is ofcourse in dpram1
and the latter is allocated from main memory. Other access to the dpram1
could be through im_dprambase, im_dpram1, or DPRAM_BASE (besides 
hard coding). Checking the use of these, I conclude that they are only
used to access memory regions in dpram2 or dpram3.

>> I have replaced the calls to cpm_dpalloc with cpm_dpalloc_fixed and an
>> adress way up in the dpram1 region.

>Very bad idea.
Why is this a bad idea ? Assuming that the region of dpram1 that is 
managed
by the cpm_dpxxxx functions is free, there is as far as I can see 
absolutely
no problem of allocating the buffer descriptors elswhere within dpram1.
As the code is now (running on my hardware), the buffer descriptors for 
smc1
are allocated from 0x80 to 0xC0, this according to cpm_dpdump(). 

nfo @0xc023e6d0 (13 slots empty / 16 max)
  Free:
    0x000000e0-0x00004000 (16160)

  Taken:
    0x00000080-0x000000c0 (64) commproc
    0x000000c0-0x000000e0 (32) commproc

By using cpm_dpalloc_fixed, I have move these up to 0x3300 and so far not
detected any problems.

>> My question is; do you know which code is using the dpram1 addresses 
>> below
>> CPM_DATAONLY_BASE ?

>The SMC1 and SMC2 peripherals, just like the comment says.
I believe the smcs uses this area, but I do not understand what those 128
bytes are used for. Something related to smc is put there, and I would 
like
to understand what that something is, and then move it out of there.

>> This region must be used by something (smc ?), because when I clear 
>> from
>> offset 0x00 to 0x80 the serial port stop responding.

>Yep.

I am still stuck on this issue so any help is very much apreciated.

Regards,
Morten
