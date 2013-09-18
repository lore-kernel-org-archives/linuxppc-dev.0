Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68EF72C00DA
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Sep 2013 15:25:27 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 18 Sep 2013 15:25:26 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 79D382CE8052
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Sep 2013 15:25:22 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8I5PBDM8126736
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Sep 2013 15:25:11 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8I5PLKr032414
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Sep 2013 15:25:22 +1000
Message-ID: <52393904.4030800@linux.vnet.ibm.com>
Date: Wed, 18 Sep 2013 10:54:20 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/8][v4] powerpc/perf: Rename Power8 macros to start with
 PME
References: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1379119755-21025-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1379119755-21025-2-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2013 06:19 AM, Sukadev Bhattiprolu wrote:
> We use helpers like GENERIC_EVENT_ATTR() to list the generic events in
> sysfs. To avoid name collisions, GENERIC_EVENT_ATTR() requires the perf
> event macros to start with PME.

We got all the raw event codes covered for P7 with the help of power7-events-list.h
enumeration.

/*
 * Power7 event codes.
 */
#define EVENT(_name, _code) \
	PME_##_name = _code,

enum {
#include "power7-events-list.h"
};
#undef EVENT

Just wondering if its a good idea to name change these selected macros to be consumed
by GENERIC_EVENT_ATTR() right here for this purpose or we need to get the comprehensive
list of raw events for P8 first. Just an idea.

Regards
Anshuman
