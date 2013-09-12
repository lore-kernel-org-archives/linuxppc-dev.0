Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 681CE2C03C1
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 05:22:16 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 13 Sep 2013 00:45:46 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7F5B83940058
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 00:51:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8CJOB2u35520514
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 00:54:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8CJM6fd018332
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 00:52:07 +0530
Message-ID: <5232145B.7070009@linux.vnet.ibm.com>
Date: Fri, 13 Sep 2013 00:52:03 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v2] pstore: Adjust buffer size for compression for smaller
 registered buffers
References: <20130912064832.15340.52422.stgit@aruna-ThinkPad-T420>
 <3908561D78D1C84285E8C5FCA982C28F31CF6AB8@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31CF6AB8@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "ccross@android.com" <ccross@android.com>,
 "seiji.aguchi@hds.com" <seiji.aguchi@hds.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 12 September 2013 11:13 PM, Luck, Tony wrote:
> +	default:
> +		cmpr = 60;
> +		break;
> +	}
>
> Is this the right "default"?  It may be a good choice for a backend with a really
> tiny buffer (1 ... 999).  But less good for a (theoretical) backend with a larger
> buffer (10001 ... infinity and beyond).  Which are you trying to catch here?

Trying to catch lower buffers and also tried till 23k ( 10k * 100/45) of text with a
sample crash logit achieved a good compression of 25%. Since the upper limit is 
not known
and compression behavior is not tested above 10k chose to keep a higher default 
of 60.

> -Tony
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
