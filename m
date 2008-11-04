Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id DC37CDDE00
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Nov 2008 01:29:57 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3034708rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 04 Nov 2008 06:29:56 -0800 (PST)
Message-ID: <fa686aa40811040629o189f8ed3yc365ee124c05908c@mail.gmail.com>
Date: Tue, 4 Nov 2008 07:29:56 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "saadia dhouib" <saadia_dhouib@yahoo.fr>
Subject: Re: linux 2.6 boot failure with rfs installed in the flash disk
	(xupv2p + ppc)
In-Reply-To: <20307909.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20306038.post@talk.nabble.com> <20307909.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 3, 2008 at 11:27 AM, saadia dhouib <saadia_dhouib@yahoo.fr> wrote:
>
> Finally I created a node for ttyUL0 in /dev
> mknod /dev/ttyUL0 c 5 0
> mknod /dev/console c 5 1
>
> Then I modified /etc/inittab (from klingauf mkrootfs), I replaced the line
> :12345:respawn:/sbin/getty 9600 tts/0
> by
> ttyUL0:12345:respawn:/sbin/getty -L ttyUL0 9600 vt100
>
> Then I rebooted the kernel, and there were errors:
>
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128
> xsysace 41800000.sysace: transfer failure
> xsysace 41800000.sysace:     ctrl:  0000038a  seccnt/cmd: 0308      ver:100c
>    status:0017e31a  mpu_lba:001f91e5  busmode:   1
>    error: 00000014  cfg_lba:00000000  fatstat:0000
> xsysace 41800000.sysace: transfer failure
> xsysace 41800000.sysace:     ctrl:  0000038a  seccnt/cmd: 0308      ver:100c
>    status:0017e31a  mpu_lba:001f91e5  busmode:   1
>    error: 00000014  cfg_lba:00000000  fatstat:0000
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128
> xsysace 41800000.sysace: kicking stalled fsm; state=8 task=2 iter=12 dc=128

The sysace device can very easily get wedged up and the current driver
doesn't handle it very gracefully.  Usually the problem is seen if the
board gets reset mid-transaction (which looks a little bid different
from what you've got here; but is probably related).  The problem
should be solvable, but I haven't been able to spend any time working
on it recently.  You'll need to dig into the sysace documentation and
figure out what the status/ctrl registers mean to find out why it is
wedged up and see if you can teach the driver to work around it.

g.

>
>
>
> Could someone help me please?
> Thanks
>
>
> --
> View this message in context: http://www.nabble.com/linux-2.6-boot-failure-with-rfs-installed-in-the-flash-disk-%28xupv2p-%2B-ppc%29-tp20306038p20307909.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
