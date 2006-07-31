Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17613.33279.61050.840408@cargo.ozlabs.ibm.com>
Date: Mon, 31 Jul 2006 14:07:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH][2/2] RTAS MSI
In-Reply-To: <1154024834.29826.240.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jake Moilanen writes:

> -msiobj-y := msi.o msi-apic.o
> -msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
> -msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
> +msiobj-$(CONFIG_X86) += msi.o msi-apic.o
> +msiobj-$(CONFIG_IA64) += msi.o msi-apic.o
> +msiobj-$(CONFIG_IA64_GENERIC) += msi.o msi-apic.o msi-altix.o
> +msiobj-$(CONFIG_IA64_SGI_SN2) += msi.o msi-apic.o msi-altix.o

Doesn't this mean that ia64 configs might now get msi.o and msi-apic.o
listed twice?  Why did you need to change the
msiobj-$(CONFIG_IA64_GENERIC) and msiobj-$(CONFIG_IA64_SGI_SN2) lines
at all?

Paul.
