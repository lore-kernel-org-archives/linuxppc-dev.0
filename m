Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429601A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 16:59:35 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 00:59:33 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B4034C90027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 00:59:29 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L5xUfT12713984
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 05:59:30 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L5xT7i007130
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 00:59:30 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Sam Mendoza-Jonas <sam@mendozajonas.com>,
 Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: Fix PE location code
In-Reply-To: <20160121000842.GB10361@localhost.localdomain>
References: <1449033932-27307-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1453262173.1201.2.camel@russell.cc>
 <20160121000842.GB10361@localhost.localdomain>
Date: Thu, 21 Jan 2016 16:59:17 +1100
Message-ID: <87twm75v7u.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sam Mendoza-Jonas <sam@mendozajonas.com> writes:
> On Wed, Jan 20, 2016 at 02:56:13PM +1100, Russell Currey wrote:
>> On Wed, 2015-12-02 at 16:25 +1100, Gavin Shan wrote:
>> > In eeh_pe_loc_get(), the PE location code is retrieved from the
>> > "ibm,loc-code" property of the device node for the bridge of the
>> > PE's primary bus. It's not correct because the property indicates
>> > the parent PE's location code.
>> > 
>> > This reads the correct PE location code from "ibm,io-base-loc-code"
>> > or "ibm,slot-location-code" property of PE parent bus's device node.
>> > 
>> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> > ---
>> 
>> Tested-by: Russell Currey <ruscur@russell.cc>
>
> Thanks Russell!
>
> W.R.T including this in stable, I don't believe anything actively breaks
> without the patch, but in the event of an EEH freeze the wrong slot for
> the device will be identified, making troubleshooting more difficult.

As someone who's likely going to have to deal with the bug reports for
such things, I like the idea of this going to stable as *maybe* I'll get
fewer of them that I have to close pointing to this commit...

-- 
Stewart Smith
OPAL Architect, IBM.
