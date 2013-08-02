Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 754682C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 05:06:04 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Sat, 3 Aug 2013 04:55:33 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 56463357804E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 05:06:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72IoH3a7143764
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Aug 2013 04:50:17 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r72J60I1007377
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Aug 2013 05:06:00 +1000
Message-ID: <51FC0315.1010601@linux.vnet.ibm.com>
Date: Fri, 02 Aug 2013 14:05:57 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/8] Mark powerpc memory resources as busy
References: <51F01E06.6090800@linux.vnet.ibm.com>
 <51F01EB2.9060802@linux.vnet.ibm.com> <20130802022827.GB1680@concordia>
In-Reply-To: <20130802022827.GB1680@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm <linux-mm@kvack.org>, isimatu.yasuaki@jp.fujitsu.com,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2013 09:28 PM, Michael Ellerman wrote:
> On Wed, Jul 24, 2013 at 01:36:34PM -0500, Nathan Fontenot wrote:
>> Memory I/O resources need to be marked as busy or else we cannot remove
>> them when doing memory hot remove.
> 
> I would have thought it was the opposite?

Me too.

As it turns out the code in kernel/resource.c checks to make sure the
IORESOURCE_BUSY flag is set when trying to release a resource.

-Nathan
