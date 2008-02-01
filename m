Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id DAD48DE02C
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 06:57:39 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so321316anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Feb 2008 11:57:35 -0800 (PST)
Message-ID: <fa686aa40802011157m2b70205brae26157345331eb0@mail.gmail.com>
Date: Fri, 1 Feb 2008 12:57:35 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [RFC/PATCH v2] [POWERPC] bootwrapper: build multiple cuImages
In-Reply-To: <20080201193225.67CFAAF0057@mail201-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080201000706.18869.36903.stgit@trillian.secretlab.ca>
	<20080201193225.67CFAAF0057@mail201-sin.bigfish.com>
Cc: scotwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/1/08, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> What if it was something like:
>
> image-$(CONFIG_MPC832x_MDS)             += cuImage.mpc832x_mds
> image-$(CONFIG_MPC832x_RDB)             += cuImage.mpc832x_rdb
> image-$(CONFIG_MPC834x_ITX)             += cuImage.mpc8349emitx \
>                                            cuImage.mpc8349emitxgp
> platform-$(CONFIG_MPC83xx)              += cuboot-83xx.o
>
> $(obj)/cuImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits) $(platform-y)
>         $(call if_changed,wrap,$(platform-y),(dtstree)/$*.dts)
>
> Which would eliminate making all the unnecessary bits of platform code
> and enabling the smart bits to be factored out of the wrapper?  It would
> also make the dependency between the board and the platform code
> specific.It would also prevent building more than one platform at a
> time, but I don't think that's really possibly anyway?

It *is* possible, which is the goal of this patch.

:-D

There are only a few bits of non-multiplatform stuff left for 6xx
compatible platforms and those won't take too long to clear out.

The biggest part of the problem is the overloading of the cuImage.%
target.  If the wrapper was encoded in the target then the problem
would go away.  For example:

image-$(CONFIG_LITE5200)             += cuImage-52xx.lite5200b
image-$(CONFIG_MPC832x_MDS)             += cuImage-83xx.mpc832x_mds
image-$(CONFIG_MPC832x_RDB)             += cuImage-83xx.mpc832x_rdb
image-$(CONFIG_MPC834x_ITX)             += cuImage-83xx.mpc8349emitx \
                                           cuImage-83xx.mpc8349emitxgp

And then have targets for each of the cuImage-<platform>.%, like so:

$(obj)/cuImage-52xx-%: vmlinux $(dtstree)/%.dts $(wrapperbits)
        $(call if_changed,wrap,cuboot-52xx,(dtstree)/$*.dts)
$(obj)/cuImage-83xx-%: vmlinux $(dtstree)/%.dts $(wrapperbits)
        $(call if_changed,wrap,cuboot-83xx,(dtstree)/$*.dts)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
