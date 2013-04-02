Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 609D82C0139
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 21:39:04 +1100 (EST)
Date: Tue, 2 Apr 2013 12:38:39 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH 3/3] powerpc/mpc512x: add platform code for MPC5125.
Message-ID: <20130402123839.612d18e6@crub>
In-Reply-To: <515AA9A2.1090100@sirius-es.it>
References: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
 <1363801314-16967-4-git-send-email-matteo.facchinetti@sirius-es.it>
 <20130330233241.25846714@crub> <515AA9A2.1090100@sirius-es.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 02 Apr 2013 11:49:22 +0200
Matteo Facchinetti <matteo.facchinetti@sirius-es.it> wrote:
...
> >          if (of_machine_is_compatible("fsl,mpc5121"))
> >                  return "fsl,mpc5121-psc";
> >
> >          if (of_machine_is_compatible("fsl,mpc5125"))
> >                  return "fsl,mpc5125-psc";
> >
> > but note that it will only work if we add these compatibles
> > to the compatible list of the root nodes in 5121 and 5125
> > device trees.
> 
> I agree with you.
> 
> But I don't like that:
> "fsl,mpc5121" is already present in <mpc5121.dtsi> and after its 
> inclusion in <mpc5121ads.dts> , compatible root node value is replaced 
> by "fsl,mpc5121ads".
> 
> Idea is automatically generate
>      compatible = "fsl,mpc5121", "fsl,mpc5121ads";
> using dtsi hierarchy.
> 
> Is there a way to extend compatible values instead of replace it?

Not that I am aware of. Note that the compatible list should
specify the compatibility from most specific to most general, so
the list in mpc5121ads.dts would look like

    compatible = "fsl,mpc5121ads", "fsl,mpc5121";

We can patch in-tree mpc512x dts files accordingly.

Thanks,

Anatolij

--
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0  Fax: +49-8142-66989-80 Email: office@denx.de
