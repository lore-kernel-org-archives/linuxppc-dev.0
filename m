Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16AFB1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 12:25:47 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 25 Sep 2014 22:25:44 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A35EBC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 22:14:25 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8Q2PfYk4653500
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 02:25:41 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8Q2PdAE005631
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 22:25:41 -0400
Date: Thu, 25 Sep 2014 19:25:20 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 01/10] tools/perf: support parsing parameterized events
Message-ID: <20140926022520.GA8997@us.ibm.com>
References: <1411586844-21381-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1411586844-21381-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20140925085858.GA20915@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140925085858.GA20915@krava.brq.redhat.com>
Cc: ak@linux.intel.com, Michael Ellerman <michaele@au1.ibm.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org, eranian@google.com,
 dev@codyps.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:
| On Wed, Sep 24, 2014 at 12:27:15PM -0700, Sukadev Bhattiprolu wrote:
| > From: Cody P Schafer <cody@linux.vnet.ibm.com>
| > 
| > Enable event specification like:
| > 
| > 	pmu/event_name,param1=0x1,param2=0x4/
| > 
| > Assuming that
| > 
| > 	/sys/bus/event_source/devices/pmu/events/event_name
| > 
| > Contains something like
| > 
| > 	param2=foo,bar=1,param1=baz
| 
| hum, so what happened to the '?' ... AFAIU from out last discussion,
| you wanted to mark terms which are mandatory and user must provide
| values for them.. and I thought the decision was to have following
| alias record:
| 
|   $ cat /sys/bus/event_source/devices/pmu/events/event_name
|   param2=?,bar=1,param1=?
| 
| while perf would scream if any of param1/2 wasnt filled like for:
|   pmu/event_name,param1=0x1/

Sorry, I meant to make perf list consistent with sysfs.

Consider these two sysfs entries:

	$ cat HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE 
	domain=0x2,offset=0xe0,starting_index=core,lpar=0x0

	$ cat HPM_0THRD_NON_IDLE_CCYC__VCPU_HOME_CORE 
	domain=0x3,offset=0xe0,starting_index=vcpu,lpar=sibling_guest_id

In the first one, starting_index refers to a 'core' while in the second
it refers to a vcpu. This serves as a "hint" for the parameter's meaning.

By replacing both with 'starting_index=?' we lose that hint.

Should we fix both sysfs and 'perf list' to say

	starting_index=?core 

Sukadev
