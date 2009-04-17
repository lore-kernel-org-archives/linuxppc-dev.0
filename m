Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 106D3DDFAE
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 04:58:41 +1000 (EST)
Received: by gxk1 with SMTP id 1so1775281gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 11:58:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C0729E57E@SDCEXCHANGE01.ad.amcc.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
	<625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Apr 2009 12:57:33 -0600
Message-ID: <fa686aa40904171157x207d6493v9a37e2d8c61113d3@mail.gmail.com>
Subject: Re: Question about DBCR0 initialization for 440
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>,
	hollisb@us.ibm.com, Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey John

We just discussed this on IRC.  Go ahead and generate a patch to
unconditionally turn on DBCR0[IDM] in head_44x.S.  Don't even bother
wrapping it in an #ifdef CONFIG_somthing block.  It should be safe,
but we'll throw it into -next and see if anyone complains.  If it does
cause problems, then it can be reworked to something a wee bit more
conservative.

g.

On Fri, Apr 17, 2009 at 11:22 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> w=
rote:
> On Fri, Apr 17, 2009 at 11:46 AM, John Linn <John.Linn@xilinx.com> wrote:
>> Josh, any thoughts on putting this into head_44x.S?
>
> The code in the fsl file looks like the right solution. =A0I do have an
> odd question though, in that it's hard for the
> kernel to really know if something like a BDI is running. =A0Namely,
> that config option doesn't cover RiscWatch in an obvious manner.
>
> I also wonder if it's possible to have a host system be setting those
> registers in a guest KVM system so the guest could be debugged with
> gdb... =A0Hollis, any idea on that?
>
> josh
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
