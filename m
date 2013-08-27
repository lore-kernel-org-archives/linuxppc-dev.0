Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09A1F2C00D4
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 19:39:42 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 15:01:49 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 983BB1258051
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 15:09:27 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7R9fEQU33554588
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 15:11:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7R9dZlx030704
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 15:09:36 +0530
Message-ID: <521C73D7.1010007@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 15:09:35 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Seiji Aguchi <seiji.aguchi@hds.com>
Subject: Re: [RFC PATCH v2 06/11] pstore: Add decompression support to pstore
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131821.3338.27923.stgit@aruna-ThinkPad-T420>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0B8@USINDEM103.corp.hds.com>
In-Reply-To: <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0B8@USINDEM103.corp.hds.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "ccross@android.com" <ccross@android.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 23 August 2013 04:34 AM, Seiji Aguchi wrote:
>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Aruna Balakrishnaiah
>> Sent: Friday, August 16, 2013 9:18 AM
>> To: linuxppc-dev@ozlabs.org; tony.luck@intel.com; linux-kernel@vger.kernel.org; keescook@chromium.org
>> Cc: jkenisto@linux.vnet.ibm.com; ananth@in.ibm.com; benh@kernel.crashing.org; cbouatmailru@gmail.com;
>> mahesh@linux.vnet.ibm.com; ccross@android.com
>> Subject: [RFC PATCH v2 06/11] pstore: Add decompression support to pstore
>>
>> Based on the flag 'compressed' set or not, pstore will decompress the
>> data returning a plain text file. If decompression fails for a particular
>> record it will have the compressed data in the file which can be
>> decompressed with 'openssl' command line tool.
> If the decompression fails and openssl doesn't work, the worst case is that users can't read the entry.
> In that case, pstore is meaningless at all.

If decompression fails and openssl doesn't work. We have python module zlib to 
decompress
the zlib data. zlib.decompress() should do the trick.

> Also, for users who want to get a single panic message, a compression is not needed.
>
> So, I think we still have to support non-compression mode.
> (IMO, pstore can take kdump as a model. Kdump supports both compression and non-compression mode.)
>
> But, if you think my comment is outside this patchset, it's OK.
> We can make it with a separate patch.
>
> Seiji
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
