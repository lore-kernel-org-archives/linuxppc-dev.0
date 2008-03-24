Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 109FCDDF9D
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 22:47:41 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2OBlbFb018546
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 07:47:37 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2OBlbS5175438
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 05:47:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2OBla2G017812
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 05:47:37 -0600
Date: Mon, 24 Mar 2008 06:45:31 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RESEND] [PATCH 1/2 v2] [OF] Add of_device_is_available function
Message-ID: <20080324064531.61c7a8f7@zod.rchland.ibm.com>
In-Reply-To: <18407.37606.990271.551578@cargo.ozlabs.ibm.com>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301174825.57715d46@zod.rchland.ibm.com>
	<18407.37606.990271.551578@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 24 Mar 2008 22:39:18 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Josh Boyer writes:
> 
> > This adds a function called of_device_is_available that checks the state
> > of the status property of a device.  If the property is absent or set to
> > either "okay" or "ok", it returns 1.  Otherwise it returns 0.
> 
> Well actually...
> 
> > +	if (statlen > 0) {
> > +		if (!strncmp(status, "okay", 4) || !strncmp(status, "ok", 2))
> > +			return 1;
> 
> The second test will succeed for anything that starts with "ok", so
> the first test is redundant.  I suspect you want strcmp instead of
> strncmp in both tests.

GRR!  That's what I had in the original patch and you told me to use
strncmp instead.

If you want I can send out a v3.  Otherwise, perhaps you could just
munge the patch?

josh
