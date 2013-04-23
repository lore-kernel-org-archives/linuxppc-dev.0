Return-Path: <ananth@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E0EF2C016A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:05:52 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 23 Apr 2013 01:05:46 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D5C4D6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 01:05:40 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3N55hNS346768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 01:05:43 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3N55g4o002377
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 23:05:43 -0600
Date: Tue, 23 Apr 2013 10:35:40 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/rtas_flash: New return code to indicate FW
 entitlement expiry
Message-ID: <20130423050540.GA30690@in.ibm.com>
References: <20130419114410.19115.35846.stgit@hegdevasant>
 <1366677610.2886.8.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366677610.2886.8.camel@pasglop>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 10:40:10AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-04-19 at 17:14 +0530, Vasant Hegde wrote:
> > Add new return code to rtas_flash to indicate firmware entitlement
> > expiry. This will be used by the update_flash script to return
> > appropriate message to the user.
> 
> What's the point of that patch ? It adds a definition to a private .c
> file not exposed to user space and doesn't do anything with it ...

Ben,

The userspace update_flash script invokes the rtas_flash module. With
upcoming System p servers, the firmware will have the entitlement dates
encoded in it and RTAS will return an error if the entitlement has
expired. All we need from this module is for it to return that new error
which will then be communicated to the user by the update_flash.

Ananth
