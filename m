Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZ0Lt4JTKzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:53:26 +1100 (AEDT)
Message-ID: <1459230799.21529.2.camel@russell.cc>
Subject: Re: [PATCH V2 1/2] pseries/eeh: Refactor the configure bridge RTAS
 tokens
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 Mar 2016 15:53:19 +1000
In-Reply-To: <20160329052608.GA2614@gwshan>
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
 <20160329052608.GA2614@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-29 at 16:26 +1100, Gavin Shan wrote:
> On Tue, Mar 29, 2016 at 12:51:50PM +1000, Russell Currey wrote:
<snip>
> > 	/*
> > 	 * Necessary sanity check. We needn't check "get-config-addr-info"
> > @@ -93,8 +98,7 @@ static int pseries_eeh_init(void)
> > 	    (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
> > 	     ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE)	||
> > 	    ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE	||
> > -	    (ibm_configure_pe == RTAS_UNKNOWN_SERVICE		&
> > &
> > -	     ibm_configure_bridge == RTAS_UNKNOWN_SERVICE)) {
> > +	    ibm_configure_pe == RTAS_UNKNOWN_SERVICE) {
> > 		pr_info("EEH functionality not supported\n");
> > 		return -EINVAL;
> > 	}
> Since you're here, you can do similar thing to @ibm_read_slot_reset_state
> and @ibm_read_slot_reset_state?

Ah, didn't notice there was a similar thing going on there.  Will fix.
> 
> > 
> > @@ -621,18 +625,9 @@ static int pseries_eeh_configure_bridge(struct
> > eeh_pe *pe)
> > 	if (pe->addr)
> > 		config_addr = pe->addr;
> > 
> > -	/* Use new configure-pe function, if supported */
> > -	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
> > -		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
> > -				config_addr, BUID_HI(pe->phb->buid),
> > -				BUID_LO(pe->phb->buid));
> > -	} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
> > -		ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
> > -				config_addr, BUID_HI(pe->phb->buid),
> > -				BUID_LO(pe->phb->buid));
> > -	} else {
> > -		return -EFAULT;
> > -	}
> > +	ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
> > +			config_addr, BUID_HI(pe->phb->buid),
> > +			BUID_LO(pe->phb->buid));
> > 
> Russell, it seems not working if "ibm,configure-pe" and "ibm,configure-
> bridge" are all
> missed from "/rtas".

If they're both missing, then the init should fail as ibm_configure_pe will
be RTAS_UNKNOWN_SERVICE, so this code should never be called.

>  Also, I don't think we need backport it to 3.10+ as it's not fixing
> any bugs if I'm correct enough.

This patch doesn't, but the second patch does.

> 
> Thanks,
> Gavin
> 
> 
> > 
> > 	if (ret)
> > 		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x
> > (%d)\n",
