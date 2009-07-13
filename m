Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7A61EB707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 02:02:20 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <6213bc560907130839t36e28d5fr34191ccb290c9cf8@mail.gmail.com>
References: <6213bc560907130016n2f2d5066t3dc88032200da8ef@mail.gmail.com>
	<fa686aa40907130802h3a6875f7gf21d41974974a7e4@mail.gmail.com>
	<6213bc560907130839t36e28d5fr34191ccb290c9cf8@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 13 Jul 2009 10:01:57 -0600
Message-ID: <fa686aa40907130901r181fea87k3f8da151a50edb75@mail.gmail.com>
Subject: Re: Soft Reset for PPC44x Virtex 5 hangs saying Restarting System
To: srikanth krishnakar <skrishnakar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 13, 2009 at 9:39 AM, srikanth
krishnakar<skrishnakar@gmail.com> wrote:
>
>
> On Mon, Jul 13, 2009 at 8:32 PM, Grant Likely <grant.likely@secretlab.ca>
> wrote:
>>
>> On Mon, Jul 13, 2009 at 1:16 AM, srikanth
>> krishnakar<skrishnakar@gmail.com> wrote:
>> > Hi all,
>> >
>> > Kernel : Linux-2.6.29
>> > Arch: Powerpc (ppc44x)
>> > Target: Xilinx ML507 Virtex5
>> >
>> > I have an issue in "Reset System" of Xilinx ML507 target board. I am
>> > using
>> > Compact Flash to boot the target ( using system ACE file to boot the
>> > target), during the process reset or reboot command on the target, I a=
m
>> > not
>> > able to reboot the target completely, here is the snapshot:
>>
>> Where is your boot code located? =A0In BRAM? =A0or SDRAM?
>
> It is located in BRAM.
>

Then most likely the process of booting modifies the initial data in
BRAM such that it will not be able to reboot the system.

> How can I reboot the system, while resetting the FPGA core completely ?

To reset and reconfigure the FPGA, you need to modify the systemace
driver to provide a system reset routine.  See the systemace user
manual for details on how to do this.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
