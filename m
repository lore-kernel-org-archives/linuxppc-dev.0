Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id A1B8267BC8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 03:07:31 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1737979ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 08:07:29 -0800 (PST)
Message-ID: <528646bc0612120807x1af8ca06icfc53bea567a2a46@mail.gmail.com>
Date: Tue, 12 Dec 2006 09:07:28 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrea Galbusera" <andrea.galbusera@teamware.it>
Subject: Re: Which kernel for Lite5200 based target board?
In-Reply-To: <1165936728.32602.59.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1165936728.32602.59.camel@localhost.localdomain>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/12/06, Andrea Galbusera <andrea.galbusera@teamware.it> wrote:
> Hi all,
>
> I read a lot about this but I'm still confused. I have a Lite5200 based
> target board and I'm experimenting with a few kernels but I can't figure
> out which is the best to stay with.
<SNIP>
> I know Sylvain Munaut is/was also maintaining a kernel tree with working
> support for IDE and Bestcomm. This tree seems not very active to me but
> my git wisdom is very very poor and I may be wrong :-(

Sylvain and I are actively working on the mpc52xx support in
arch/powerpc.  You can choose between an arch/ppc or an arch/powerpc
kernel (arch/ppc the old 32 bit support; and it is steadly being
migrated over to arch/powerpc).  If you want to stick with arch/ppc;
you can use any recent 2.6 kernel and search the mailing list for the
patches adding bestcomm, ethernet and IDE support.  If you want to use
an arch/powerpc kernel, look at my tree on http://git.secretlab.ca.
The lite5200 branch already contains IDE, bestcomm, ethernet, PCI,
etc.

> Unfortunately my tests tell me none of the listed kernels works out of
> the box for the target: the former being not officially supported by
> DENX for the Lite5200 target, the latter having a Lite5200/Lite5200B
> configuration target.

My tree works for me; but you'll need to update to a recent u-boot.
arch/powerpc requires passing in a flattened device tree at boot time.
 Look in arch/powerpc/boot/dts/lite5200b.dts for the device tree
source.  You'll also need to get the device tree compiler from
www.jdl.org.

Plus since Sylvain and I are actively working on this stuff; there's a
better chance that we can help.  :)

cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
