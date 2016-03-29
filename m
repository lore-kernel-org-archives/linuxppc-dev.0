Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZSQJ586hzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 10:58:00 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 30 Mar 2016 09:27:39 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 515B62CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 10:27:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2TNRRjV12845516
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 10:27:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2TNR35f032509
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 10:27:03 +1100
Date: Wed, 30 Mar 2016 10:07:01 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 2/2] pseries/eeh: Handle RTAS delay requests in
 configure_bridge
Message-ID: <20160329230701.GA5670@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
 <1459219911-14110-2-git-send-email-ruscur@russell.cc>
 <20160329094936.GB10585@gwshan>
 <1459288877.4182.4.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1459288877.4182.4.camel@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 30, 2016 at 08:01:17AM +1000, Russell Currey wrote:
>On Tue, 2016-03-29 at 20:49 +1100, Gavin Shan wrote:
>> On Tue, Mar 29, 2016 at 12:51:51PM +1000, Russell Currey wrote:
.../...

>> > 
>> > +		switch (ret) {
>> > +		case 0:
>> > +			return ret;
>> > +		case RTAS_EXTENDED_DELAY_MIN:
>> > +		case RTAS_EXTENDED_DELAY_MIN+1:
>> > +		case RTAS_EXTENDED_DELAY_MIN+2:
>> > +			mwait = rtas_busy_delay(ret);
>> > +			break;
>> > +		default:
>> > +			goto err;
>> > +		}
>> > +
>> > +		max_wait -= mwait;
>> If you like, the block can be simplified to as below. In that case,
>> tag #err isn't needed.
>> 
>>                 if (!ret)
>>                         return ret;
>> 
>>                 max_wait -= rtas_busy_delay(ret);
>> 
>That doesn't catch the case where the return value is greater than
>RTAS_EXTENDED_DELAY_MIN+2, in which case we would be sleeping for at least
>1 second.  However, I am going to change it so that any delay above 100ms
>is just treated as if it was 100ms, so I can simplify the code there and
>probably remove the switch and goto.
>

Yeah, we need update @max_wait and check it in advance. The point
is to remove the tag and simplify the switch block if you want, but
it's not a big deal:

		max_wait -= rtas_busy_delay_time(ret)
		if (ret <= 0 || max_wait < 0)
			return ret;

		rtas_busy_delay(ret);

Thanks,
Gavin
