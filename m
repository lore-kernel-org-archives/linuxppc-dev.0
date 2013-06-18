Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E3CF02C1040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:42:15 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 02:41:49 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5E7C01FF001C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:36:34 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8fmQ1386426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:41:48 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8flaa032175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:41:48 -0600
Date: Tue, 18 Jun 2013 16:41:44 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 00/31] EEH Support for PowerNV platform
Message-ID: <20130618084144.GA5317@shangw.(null)>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 18, 2013 at 04:33:24PM +0800, Gavin Shan wrote:

Hi Ben,

I resend the whole series of patches because some newly added patches among
it.

>Initially, the series of patches is built based on 3.10.RC1 and the patchset
>doesn't intend to enable EEH functionality for PHB3 for now. Obviously, PHB3
>EEH support on PowerNV platform is something to do in future.
>

.../...

>Change log
>==========
>
>v4 -> v5:
>	* Add patch [10/31] to make EEH core running with single kthread.
>	* Add patch [11/31] to trace the time stamp of last error in the last
>	  hour for specific PE
>	* Add patch [12/31] to purge duplicate EEH events
>	* Add patch [14/31] for EEH core to handle special event, which doesn't
>	  have binding PE
>	* Add patch [22/31] to support I/O chip next_error() backend. Almost all
>	  stuff from original pci_err.c moved to eeh-ioda.c. Appropriate cleanup
>	  is applied as well.
>	* Changed [27/31] to allow clearing specific OPAL notifier event in the
>	  cache traced by variable "last_notified_mask"
>	* Changed [29/31] to register OPAL event notifier on post-initilization
>	  period.

Please review those patches at your available time. The left patches shouldn't
be changed or with minor changes without affecting the whole logic. Thanks in
advance for your time :-)

The target of v5 is mainly for following aspects according to your comments:

- Make EEH core running with single-kthread.
- Add new eeh_ops::next_error() for PowerNV platform to use. Almost all stuff
  of original pci-err.c moved to the backend.
- Hanle special event (without binding PE) in EEH core. The special events
  are purely come from PowerNV platform (error interrupts).


Thanks,
Gavin
