Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36A2B1A0374
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 17:05:54 +1100 (AEDT)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Fri, 27 Mar 2015 02:05:52 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: handle OPAL_SUCCESS return in
 opal_sensor_read
In-Reply-To: <5513D514.1000504@fr.ibm.com>
References: <1427305834-6737-1-git-send-email-clg@fr.ibm.com>
 <m3fv8s7k2p.fsf@oc8180480414.ibm.com> <5513D514.1000504@fr.ibm.com>
Date: Fri, 27 Mar 2015 17:05:45 +1100
Message-ID: <m3vbhn3rgm.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cedric Le Goater <clg@fr.ibm.com> writes:
> The sensor service in OPAL only handles one FSP request at a time and 
> returns OPAL_BUSY if one is already in progress. The lock covers this case 
> but we could also remove it return EBUSY to the driver or even retry the 
> call. That might be dangerous though. 

Retrying the call should be okay.

Just because FSP wants to do things serially doesn't mean non-FSP does :)

> Changing OPAL to handle simultaneously multiple requests does not seem really 
> necessary, it won't speed up the communication with the FSP and that is the
> main bottleneck.

Only on FSP systems though, and all of the OpenPower machines don't have
FSPs :)
