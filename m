Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZPql04M7zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 09:01:22 +1100 (AEDT)
Message-ID: <1459288877.4182.4.camel@russell.cc>
Subject: Re: [PATCH V2 2/2] pseries/eeh: Handle RTAS delay requests in
 configure_bridge
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 08:01:17 +1000
In-Reply-To: <20160329094936.GB10585@gwshan>
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
 <1459219911-14110-2-git-send-email-ruscur@russell.cc>
 <20160329094936.GB10585@gwshan>
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

On Tue, 2016-03-29 at 20:49 +1100, Gavin Shan wrote:
> On Tue, Mar 29, 2016 at 12:51:51PM +1000, Russell Currey wrote:
> > 
> > In the configure_pe and configure_bridge RTAS calls, the spec states
> > that values of 9900-9905 can be returned, indicating that software
> > should delay for 10^x (where x is the last digit, i.e. 990x)
> > milliseconds and attempt the call again. Currently, the kernel doesn't
> > know about this, and respecting it fixes some PCI failures when the
> > hypervisor is busy.
> > 
> > The delay is capped at 0.2 seconds.
> > 
> When talking about RTAS calls, it might be better to have their full
> names defined in PAPR spec. So I guess it'd better to replace
> configure_pe
> and configure_bridge with their corresponding full RTAS call names:
> "ibm,configure-pe" and "ibm,configure-bridge".
Makes sense, will do.
> 
> > 
> > Cc: <stable@vger.kernel.org> # 3.10-
> I think it would be #3.10+.
> 
<snip>
> > +		/*
> > +		 * RTAS can return a delay value of up to 10^5
> > milliseconds
> > +		 * (RTAS_EXTENDED_DELAY_MAX), which is too long.  Only
> > respect
> > +		 * the delay if it's 100ms or less.
> > +		 */
> > 
> The PAPR spec states that the delay can be up to 10^5ms. The spec also
> suggests
> the maximal delay is 10^2. I guess it's worthy to mention it in the above
> comments
> if you like.

Yeah, I'll expand on that in the comment.
> 
> > 
> > +		switch (ret) {
> > +		case 0:
> > +			return ret;
> > +		case RTAS_EXTENDED_DELAY_MIN:
> > +		case RTAS_EXTENDED_DELAY_MIN+1:
> > +		case RTAS_EXTENDED_DELAY_MIN+2:
> > +			mwait = rtas_busy_delay(ret);
> > +			break;
> > +		default:
> > +			goto err;
> > +		}
> > +
> > +		max_wait -= mwait;
> If you like, the block can be simplified to as below. In that case,
> tag #err isn't needed.
> 
>                 if (!ret)
>                         return ret;
> 
>                 max_wait -= rtas_busy_delay(ret);
> 
That doesn't catch the case where the return value is greater than
RTAS_EXTENDED_DELAY_MIN+2, in which case we would be sleeping for at least
1 second.  However, I am going to change it so that any delay above 100ms
is just treated as if it was 100ms, so I can simplify the code there and
probably remove the switch and goto.
