Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwFPq49WFzF15w
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 09:46:22 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25Mi18Z135680
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 17:46:19 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghec21avq-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 17:46:19 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 5 Mar 2018 15:46:18 -0700
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
 <87lgforngp.fsf@concordia.ellerman.id.au>
 <20180220180621.11265945@kitsune.suse.cz>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 5 Mar 2018 19:46:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180220180621.11265945@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael, Michal,

I got back from vacation. Checking this one.

On 02/20/2018 02:06 PM, Michal Suchánek wrote:
>> I did it the way I did because otherwise we waste memory on every
>> system on earth just to support a use case that we don't actually
>> intend for anyone to ever use - ie. migrating from a patched machine
>> to an unpatched machine.

If this thread eventually closes in 'ok, so that memory has to be
reserved/wasted anyway', that can be done only in pseries, right?

It seems not so much memory for this particular platform/hardware.

> If you have multiple hosts running some LPMs and want to update them
> without shutting down the whole thing I suppose it might easily happen
> that a machine (re)started on a patched host is migrated to unpatched
> host.

Right, but that should be temporary, I think -- after updating some of
the hosts, the LPAR(s) can be migrated back to one of them, where the
fallback flush is not required anymore.

>> I think I'm inclined to leave it the way it is, unless you feel
>> strongly about it Michal?

> I think it would be more user friendly to either support the fallback
> method 100% or remove it and require patched firmware.

I beg to disagree.  Since the matter is a security issue, the option
of still have some sort of fix that works on unpatched firmware does
look good and friendly to users (rather than require 'you _must_ get
the firmware update') IMHO.

cheers,
Mauricio
