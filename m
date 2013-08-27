Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F4F32C007B
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 15:20:00 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 10:43:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E91DFE0053
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 10:50:25 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7R5LRDB42926218
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 10:51:27 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7R5JmO9003864
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 10:49:50 +0530
Message-ID: <521C36F4.8030607@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 10:49:48 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>, Seiji Aguchi <seiji.aguchi@hds.com>
Subject: Re: [RFC PATCH v2 04/11] pstore: Add compression support to pstore
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131805.3338.68767.stgit@aruna-ThinkPad-T420>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0D7@USINDEM103.corp.hds.com>
 <3908561D78D1C84285E8C5FCA982C28F31CC7AC0@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31CC7AC0@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
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

On Friday 23 August 2013 04:47 AM, Luck, Tony wrote:
> <1>[  383.209057] RIP  [<ffffffff813d3946>] sysrq_handle_crash+0x16/0x20
> <4>[  383.209057]  RSP <ffff88006f551e80>
> <4>[  383.209057] CR2: 0000000000000000
> <4>[  383.209057] ---[ end trace 04a1cddad37b4b33 ]---
> <3>[  383.209057] pstore: compression failed for Part 2 returned -5
> <3>[  383.209057] pstore: Capture uncompressed oops/panic report of Part 2
> <3>[  383.209057] pstore: compression failed for Part 5 returned -5
>
> Interesting.  With ERST backend I didn't see these messages.  Traces in
> pstore recovered files go as far as the line before the "---[ end trace 04a1cddad37b4b33 ]---"
>
> Why the difference depending on which back end is in use?
>
> But I agree that we shouldn't have these messages.  They use up space
> in the persistent store that could be better used saving some more lines
> from earlier in the console log.

Yeah. We can remove these messages as it will add to the space consumed. But it 
would
be good to know why the compression failed with efivars case.

Seiji,

Could you let us know the efivars buffer size with which the pstore is 
registered when
the failure occurred.

Regards,
Aruna


>
> -Tony
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
