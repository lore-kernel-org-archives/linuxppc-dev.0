Return-Path: <olof@lixom.net>
Date: Thu, 5 Oct 2006 21:22:00 -0500
From: Olof Johansson <olof@lixom.net>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] linux,tce-size property is 32 bits
Message-ID: <20061005212200.26f648e2@pb15>
In-Reply-To: <200610061216.32315.jk@ozlabs.org>
References: <20061005032800.GH24705@localdomain>
	<1160039899.22232.54.camel@localhost.localdomain>
	<20061005143244.GJ24705@localdomain>
	<200610061216.32315.jk@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, matthltc@us.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 6 Oct 2006 12:16:30 +1000 Jeremy Kerr <jk@ozlabs.org> wrote:

> 
> > AFAICT this was introduced by the "Constify & voidify get_property()"
> > series which went in post-2.6.18 so no backport for -stable is
> > needed.  Not sure about RHEL5.
> 
> That patch (954a46e2d5aec6f59976ddeb1d232b486e59b54a) did touch the 
> declaration of sizep, but only changed it from an unsigned long * to an 
> const unsigned long *.

No it didn't:

file:d67af2c657544ef5b0a6386a9c45a31de2fb4681 -> file:bbf2e34dc3582442a9e65c2a404c4e7ddd31619e
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -267,13 +267,12 @@ static void iommu_table_setparms(struct
 					struct iommu_table *tbl)
 {
 	struct device_node *node;
-	unsigned long *basep;
-	unsigned int *sizep;
+	const unsigned long *basep, *sizep;


-Olof
