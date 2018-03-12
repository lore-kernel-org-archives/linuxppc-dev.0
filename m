Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400YZc3TFzzDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:08:56 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2CN4xdk105280
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:08:54 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gp1cnb290-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:08:53 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 12 Mar 2018 19:08:52 -0400
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
 <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
 <876069flhq.fsf@concordia.ellerman.id.au>
 <20180306135522.040707de@kitsune.suse.cz>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 20:08:47 -0300
MIME-Version: 1.0
In-Reply-To: <20180306135522.040707de@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f11fdded-9d5e-d06f-b75e-d0a802b2005d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael and Michal,

Got back to this; sorry for the delay.

On 03/06/2018 09:55 AM, Michal Suchánek wrote:
> Michael Ellerman<mpe@ellerman.id.au>  wrote:

>> I*think*  the patch below is all we need, as well as some tweaking of
>> patch 2, are you able to test and repost?

> Enabling the fallback flush always looks a bit dodgy but
> do_rfi_flush_fixups will overwrite the jump so long any other fixup is
> enabled.

I agree; the 'Using fallback displacement flush' message is misleading
(is the system slower/fallback or not? Ô_o)

The suggested patch is definitely more contained within pseries, but
the informational part seemed dodgy IMHO too.

So I wrote something with a new function parameter to force the init of
the fallback flush area (true in pseries, false in powernv).  Not that
contained, but it seemed to convey the intent here in a clear way.

That's v2, just sent.

cheers,
Mauricio
