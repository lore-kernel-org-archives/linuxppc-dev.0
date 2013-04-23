Return-Path: <ananth@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EBB02C05DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:47:15 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Mon, 22 Apr 2013 23:47:12 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 69B741FF0039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 23:42:07 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3N5l9j4114236
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 23:47:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3N5l8Ka013762
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 23:47:09 -0600
Date: Tue, 23 Apr 2013 11:17:06 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/rtas_flash: New return code to indicate FW
 entitlement expiry
Message-ID: <20130423054706.GC30690@in.ibm.com>
References: <20130419114410.19115.35846.stgit@hegdevasant>
 <1366677610.2886.8.camel@pasglop> <20130423050540.GA30690@in.ibm.com>
 <1366695150.2886.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366695150.2886.14.camel@pasglop>
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

On Tue, Apr 23, 2013 at 03:32:30PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-04-23 at 10:35 +0530, Ananth N Mavinakayanahalli wrote:
> > On Tue, Apr 23, 2013 at 10:40:10AM +1000, Benjamin Herrenschmidt wrote:
> > > On Fri, 2013-04-19 at 17:14 +0530, Vasant Hegde wrote:
> > > > Add new return code to rtas_flash to indicate firmware entitlement
> > > > expiry. This will be used by the update_flash script to return
> > > > appropriate message to the user.
> > > 
> > > What's the point of that patch ? It adds a definition to a private .c
> > > file not exposed to user space and doesn't do anything with it ...
> > 
> > Ben,
> > 
> > The userspace update_flash script invokes the rtas_flash module. With
> > upcoming System p servers, the firmware will have the entitlement dates
> > encoded in it and RTAS will return an error if the entitlement has
> > expired. All we need from this module is for it to return that new error
> > which will then be communicated to the user by the update_flash.
> 
> That doesn't answer my question :-)
> 
> What is the point of adding a #define to a piece of code without any user
> of that definition and in a file that isn't exposed to user space ?
> 
> IE. What is the point of the patch ?

Strictly, we don't need this (kernel) update...

But to keep the code in sync with PAPR, this was added. Agree that the
other return codes also don't say much about what they are for. Will
redo the patch with that info for better code readability.
