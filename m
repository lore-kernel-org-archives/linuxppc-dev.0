Return-Path: <ntl@pobox.com>
Received: from lollipop.listbox.com (lollipop.listbox.com [208.210.124.78])
	by ozlabs.org (Postfix) with ESMTP id 1E93EDDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:32:11 +1100 (EST)
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id DFF65439822
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 16:24:36 -0400 (EDT)
Date: Mon, 12 Mar 2007 15:24:00 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH 1/2] [powerpc] export symbols for use by lparcfg
Message-ID: <20070312202400.GE18478@localdomain>
References: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt wrote:
> 
> Updates the Kconfig to allow lparcfg to be built as a module, and
> add the necessary EXPORT_SYMBOLS needed for a successful build.

Well, almost exactly a year ago lparcfg was changed to bool.  Do the
reasons for that change still stand?

commit 82dfdcae0d57c842e02f037758687eef42fb7af6
Author: Paul Mackerras <paulus@samba.org>
Date:   Tue Mar 14 11:35:37 2006 +1100

    powerpc: Disallow lparcfg being a module
    
    The lparcfg code needs several things which are pretty arcane internal
    details and which we don't want to export, which means that lparcfg
    doesn't work when built as a module.  This makes it a bool instead of
    a tristate in the Kconfig so that users can't try to build it as a
    module.

> +EXPORT_SYMBOL_GPL(lppaca);

> +EXPORT_PER_CPU_SYMBOL_GPL(cpu_usage_array);

> +EXPORT_SYMBOL_GPL(vdso_data);

Hmm, I don't think lparcfg needs to access vdso_data at all.

In pseries_lparcfg_data we have:

        lrdrp = get_property(rtas_node, "ibm,lrdr-capacity", NULL);

        if (lrdrp == NULL) {
                partition_potential_processors = vdso_data->processorCount;
        } else {
                partition_potential_processors = *(lrdrp + 4);
        }

        partition_active_processors = lparcfg_count_active_processors();

But if there's no ibm,lrdr-capacity property then the system doesn't
support adding processors, so partition_potential_processors should be
equal to partition_active_processors.
