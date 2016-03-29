Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZPmk5kLczDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 08:58:46 +1100 (AEDT)
Message-ID: <1459288718.4182.1.camel@russell.cc>
Subject: Re: [PATCH V2 2/2] pseries/eeh: Handle RTAS delay requests in
 configure_bridge
From: Russell Currey <ruscur@russell.cc>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 07:58:38 +1000
In-Reply-To: <56FAA49A.6050703@linux.vnet.ibm.com>
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
 <1459219911-14110-2-git-send-email-ruscur@russell.cc>
 <56FAA49A.6050703@linux.vnet.ibm.com>
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

On Tue, 2016-03-29 at 08:51 -0700, Tyrel Datwyler wrote:
> On 03/28/2016 07:51 PM, Russell Currey wrote:
> > +		/*
> > +		 * RTAS can return a delay value of up to 10^5
> > milliseconds
> > +		 * (RTAS_EXTENDED_DELAY_MAX), which is too long.  Only
> > respect
> > +		 * the delay if it's 100ms or less.
> > +		 */
> Your changelog says the delay is capped at 0.2s. However, your comment
> in the code mentions the full 10^5ms based on the 9900-9905 codes. It
> would probably be best to expand you comment to mention in the code that
> you are only handling 9900-9902 to eliminate the confusion of looking at
> the above comment vs below implementation.
> 
> Further, despite PAPRs software note that the long busy should be
> limited to 9900-9902 you might want to add a catch to your switch to log
> any unexpected 9903-9905 or just treat them as max 0.2s delay. Firmware
> has been know to do things on occasion that the spec says it shouldn't,
> and it might not be obvious at first should you receive one of the
> longer delay codes why we are going down the error path.
> 
> -Tyrel

Good to know, thanks.  I'll respin.

- Russell
