Date: Wed, 05 Apr 2000 01:34:42 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Setting up yaboot
In-reply-to: <20000405083212.B7710@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <a04301800b510a9fc6322@[134.114.64.240]>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <200004040459.XAA03713@lists.linuxppc.org>
 <38EA7D15.C453ED94@uncc.edu> <38EACD97.113001FE@dana.ucc.nau.edu>
 <20000405083212.B7710@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:32 AM +0200 4/5/00, Olaf Hering wrote:
>On Tue, Apr 04, Tim Wojtulewicz wrote:
>
>>
>>  Is there some sort of instructions to setting up yaboot?  I managed to
>>  get LinuxPPC 2000 installed on my Pismo, and I'd like to actually be able
>>  to use it now.  Here's how I have the partitions set up.
>
>There is the suseboot.hqx at
>ftp://ftp.suse.com/pub/suse/ppc/update/BETA/
>docs are included.

Ok, I downloaded this file and got it all copied over correctly.  I
edited the os-chooser script to point to what I thought were the
correct drives.  I must be mistaken, sinced OF doesn't seem to want
to boot from the one I want.

If I boot into OF, then type 'boot' at the prompt, I get the
following error message:

boot load-size=196 adler32=2e0879a0

DEFAULT CATCH, code=70 at %SRR0: ff80b320  %SRR1:0000b030

Here's what I have for a os-chooser script:

<CHRP-BOOT>
<COMPATIBLE>
iMac,1 PowerMac1,1 PowerBook1,1 PowerMac2,1 PowerMac3,1 PowerBook2,1
</COMPATIBLE>
<DESCRIPTION>
Linux/PPC Yaboot bootloader
</DESCRIPTION>
<BOOT-SCRIPT>
" get-key-map" " keyboard" open-dev $call-method
dup 20 dump
5 + c@ 08 = if
" Booting MacOS ..." cr " boot ultra0:9,\\:tbxi" eval
else
" Booting Yaboot ..." cr " boot ultra0:10,\\yaboot" eval
then
</BOOT-SCRIPT>
</CHRP-BOOT>

As before, my MacOS partition is #9, and my boot partition is #10.

Thanks.

Tim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
