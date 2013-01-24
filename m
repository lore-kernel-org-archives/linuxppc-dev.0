Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1916F2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 10:29:23 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 24 Jan 2013 18:29:20 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id BC831C90043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 18:29:08 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0ONT8XZ260318
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 18:29:08 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0ONT7VN014558
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 21:29:08 -0200
Date: Thu, 24 Jan 2013 15:29:07 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] perf/Power: PERF_EVENT_IOC_ENABLE does not reenable event
Message-ID: <20130124232907.GA12233@us.ibm.com>
References: <20130111191117.GA9407@us.ibm.com> <20130124050505.GA14070@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130124050505.GA14070@drongo>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 Maynard Johnson <mpjohn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras [paulus@samba.org] wrote:
| > +	/*
| > +	 * If this event was disabled in record_and_restart() because we
| > +	 * exceeded the ->event_limit, this is probably a good time to
| > +	 * re-enable the event ? If we don't reenable the event, we will
| > +	 * never notify the user again about this event.
| > +	 */
| 
| The comment seems a bit tentative. :)  If the PERF_EF_START bit is set
| then we are being told to restart the event.
| 
| >  	if (!(ef_flags & PERF_EF_START))
| >  		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
| > +	else
| > +		event->hw.state &= ~PERF_HES_STOPPED;
| 
| This looks fine, though I think you could equally well just set
| event->hw.state to 0 in the else clause.  That would clear the
| UPTODATE flag too, which is appropriate since we are about to put the
| event on a hardware counter.

Agree. I submitted a new patch with better comments and patch description
and cleared the state to 0.

Thanks for the review.

Sukadev
