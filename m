Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 322ACB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 07:43:26 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B3D1FDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 07:43:24 +1000 (EST)
Date: Wed, 16 Sep 2009 01:43:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 0/7] Suspend/resume support for some 83xx/85xx/86xx boards
Message-ID: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2009 at 01:47:36AM +0400, Anton Vorontsov wrote:
> On Mon, Sep 14, 2009 at 03:45:10PM -0500, Scott Wood wrote:
> [...]
> > >You can't request the firmware in the qe driver's ->suspend()
> > >routine necause the firmware may be on e.g. NFS filesystem or USB
> > >stick (implies having QE Ethernet or QE USB fully functional).
> > 
> > Is there any way for software to read out the current firmware from
> > the device, or is it write-only?
> 
> Hm, I didn't look into iram stuff that much, but seemingly I can
> read it back and save. In the end, it's just a ram that we access
> in a weird way... Let me try it.

Okay... that might sound silly, but the microcode stuff isn't needed
at all. While the QE really shuts down, its iram is preserved. I'm
not sure why it didn't work for me before, but now it does work. Heh.

Note that QE reset is still needed, it's QE microcode reload that
we don't need. I was also curious if MPC8568 QE needs reset after
sleep, so I unpacked the board and tested it. It needs the reset just
as MPC8569. I also found a paragraph in reference manual that somewhat
proves "QE turns off during sleep" behaviour.

So here is a new patch set. Changes:

- Removed QE stuff from fsl_pmc;
- New patches added:
  powerpc/qe: QE also shuts down on MPC8568
  powerpc/qe: Implement QE driver for handling resume on MPC85xx

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
