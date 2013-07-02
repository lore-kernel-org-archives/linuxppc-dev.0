Return-Path: <neorf3k@gmail.com>
Received: from mail-bk0-x232.google.com (mail-bk0-x232.google.com
 [IPv6:2a00:1450:4008:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C41642C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 22:36:59 +1000 (EST)
Received: by mail-bk0-f50.google.com with SMTP id ik8so2308639bkc.37
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jul 2013 05:36:55 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_E64F5379-6112-484F-A674-411F41B196AF"
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: compile custom kernel for custom board with mpc5200b
From: neorf3k <neorf3k@gmail.com>
In-Reply-To: <CC3CAF69-E890-4A56-8E04-1A82D9662F7F@me.com>
Date: Tue, 2 Jul 2013 14:36:48 +0200
Message-Id: <B24571FC-9F6D-4E1D-8D22-276182B19F83@gmail.com>
References: <36A2A056-9BA2-4246-AED9-660E103475EE@me.com>
 <CACxGe6sJNv5v=uFoQaNgq9j=q0SDAxxPb2V9hzx7vLtMkuOvjQ@mail.gmail.com>
 <5D7592C8-B262-4F6F-8CCA-E5E58DC1F850@me.com>
 <CACxGe6uKUkiD07PH0A+ToaGw_03Vkn0Y6cFvNuOXMLuT1HRCHQ@mail.gmail.com>
 <CC3CAF69-E890-4A56-8E04-1A82D9662F7F@me.com>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_E64F5379-6112-484F-A674-411F41B196AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello, i'm developing an embedded linux system on a custom mpc5200b =
board, at University.

We have  a problem with a custom version of kernel: 2.6.23 and 2.6.33. =
We can't use newer version at the moment.

We are able to compile and load the kernel on Freescale Lite5200b and on =
Custom Board.

So, we have tested ethernet on both boards.=20
On Freescale, ethernet connection is ok, just tested with ping.

But on Custom Board we are having problems:
with kernel 2.6.23 we lost 98% packet loss.=20
We have tried to disable XLB PIPELINE in: =
arch/powerpc/platforms/52xx/mpc52xx_common.c
(just commenting these lines):

/* Disable XLB pipelining */
     /* (cfr errate 292. We could do this only just before ATA PIO
         transaction and re-enable it afterwards ...) */
     //out_be32(&xlb->config, in_be32(&xlb->config) | =
MPC52xx_XLB_CFG_PLDIS);

And with this, we have 10% packet loss.

In kernel 2.6.33, we have tried the same=85 but disabling or not the =
pipeline, we have 55% packet loss.

Where could i find some solutions?

Thank you

neorf=

--Apple-Mail=_E64F5379-6112-484F-A674-411F41B196AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
">Hello,&nbsp;i'm developing an embedded linux system on a custom =
mpc5200b board, at University.<div class=3D"page" title=3D"Page 9">
		=09
		</div><div><br></div><div>We have &nbsp;a problem with a =
custom version of kernel: 2.6.23 and 2.6.33. We can't use newer version =
at the moment.</div><div><br></div><div>We are able to compile and load =
the kernel on Freescale Lite5200b and on Custom =
Board.</div><div><br></div><div>So, we have tested ethernet on both =
boards.&nbsp;</div><div>On Freescale, ethernet connection is ok, just =
tested with ping.</div><div><br></div><div>But on Custom Board we are =
having problems:</div><div>with kernel 2.6.23 we lost 98% packet =
loss.&nbsp;</div><div>We have tried to disable XLB PIPELINE =
in:&nbsp;<span style=3D"font-family: Arial; =
">arch/powerpc/platforms/52xx/mpc52xx_common.c</span></div><div><span =
style=3D"font-family: Arial; ">(just commenting these =
lines):</span></div><div><span style=3D"font-family: Arial; =
"><br></span></div><div><span style=3D"font-family: Arial; "><div>/* =
Disable XLB pipelining */</div><div>&nbsp; &nbsp; &nbsp;/* (cfr errate =
292. We could do this only just before ATA PIO</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;transaction and re-enable it afterwards ...) =
*/</div><div>&nbsp; &nbsp; &nbsp;//out_be32(&amp;xlb-&gt;config, =
in_be32(&amp;xlb-&gt;config) | =
MPC52xx_XLB_CFG_PLDIS);</div><div><br></div><div>And with this, we have =
10% packet loss.</div><div><br></div><div>In kernel 2.6.33, we have =
tried the same=85 but disabling or not the pipeline, we have 55% packet =
loss.</div><div><br></div><div>Where could i find some =
solutions?</div><div><br></div><div>Thank =
you</div><div><br></div><div>neorf</div></span></div><!--?xml =
version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?-->

</body></html>=

--Apple-Mail=_E64F5379-6112-484F-A674-411F41B196AF--
