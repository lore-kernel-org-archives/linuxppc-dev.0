Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 25D272C00E1
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2013 17:59:18 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 15 Apr 2013 17:49:52 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BCE862BB0057
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2013 17:58:58 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3F7wcA26553928
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2013 17:58:53 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3F7pvgk011579
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2013 17:51:58 +1000
Message-ID: <516BB199.1000408@linux.vnet.ibm.com>
Date: Mon, 15 Apr 2013 13:21:53 +0530
From: aruna <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/8] Add version and timestamp to oops header
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
 <20130410072112.20150.10281.stgit@aruna-ThinkPad-T420>
 <20130415073138.GB30156@concordia>
In-Reply-To: <20130415073138.GB30156@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 15 April 2013 01:01 PM, Michael Ellerman wrote:
> On Wed, Apr 10, 2013 at 12:51:12PM +0530, Aruna Balakrishnaiah wrote:
>> Introduce version and timestamp information in the oops header.
>> oops_log_info (oops header) holds version (to distinguish between old
>> and new format oops header), length of the oops text
>> (compressed or uncompressed) and timestamp.
> This needs a much more detailed explanation.
>
> I think what you're doing is you're overlaying the new information so
> that the version field in oops_log_info sits in the same location as the
> length field in the old format. And then you're defining the version to
> be a value that is an illegal length.

Thats right.

> So existing tools will refuse to dump new style partitions,
> because they'll think the length is too large. You've tested that?

Yeah, I have tested that.

>
> Updated tools will know about both formats, so will be able to handle
> either old or new style partitions.
>
> Is that correct?

Yeah, thats correct.

>
> And we're adding the timestamp just because we can and it'd be nice to
> have?

Thats right. And also, the main reason behind adding timestamp is
it will be used when we create a pstore file for oops messages.
The pstore file's timestamp will reflect the timestamp in the oops-header
added during the crash.

> cheers
>
