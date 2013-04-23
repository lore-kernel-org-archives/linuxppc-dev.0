Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7FD982C0160
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 10:27:00 +1000 (EST)
Message-ID: <1366676584.2886.4.camel@pasglop>
Subject: Re: [PATCH v2 7/11] Use stop machine to update cpu maps
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 10:23:04 +1000
In-Reply-To: <515F1673.7040304@linux.vnet.ibm.com>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509E3C.2030008@linux.vnet.ibm.com> <20130404044654.GH19443@drongo>
 <515F1673.7040304@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-04-05 at 13:22 -0500, Nathan Fontenot wrote:

> Agreed, having to call stop_machine() for each cpu that gets updated is
> pretty brutal. The plus side is that PRRN events should a rare occurrence 
> and not cause too much pain.

So that doesn't happen on VPHN changes ?

> The current design ties into the of notification chain so that we can do
> the affinity update when the affinity property in the device tree is updated.
> Switching to doing one stop and updating all of the cpus would require a
> design change....and....
> 
> I went back and looked at the code again and there is another issue with
> way this is done. Tying into the of notification chain is great for
> being informed of when a property changes but the code (from patch 6/11)
> 
> +	case OF_RECONFIG_ADD_PROPERTY:
> +	case OF_RECONFIG_UPDATE_PROPERTY:
> +		update = (struct of_prop_reconfig *)data;
> +		if (!of_prop_cmp(update->dn->type, "cpu")) {
> +			u32 core_id;
> +			of_property_read_u32(update->dn, "reg", &core_id);
> +			stage_topology_update(core_id);
> +			rc = NOTIFY_OK;
> +		}
> +		break;
> 
> Does not check to see which property is being updated and just assumes
> the affinity is being updated. This code as is will do an affinity update
> every time any property of a cpu is updated or added.
> 
> Since this needs an update I will also look at possibly doing this so
> that we call stop_machine only once.

Any new patch set ?

Cheers,
Ben.
