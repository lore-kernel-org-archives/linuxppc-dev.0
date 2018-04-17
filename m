Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QB3g0nR2zF1yH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 13:45:34 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3H3igmn036532
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 23:45:32 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hd8cbj09v-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 23:45:32 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 17 Apr 2018 04:45:26 +0100
Subject: Re: [PATCH 7/7] ocxl: Document new OCXL IOCTLs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180417020950.21446-8-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 17 Apr 2018 13:45:20 +1000
MIME-Version: 1.0
In-Reply-To: <20180417020950.21446-8-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ad475a7c-68dc-899b-28ec-8d4619e18105@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/04/18 12:09, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   Documentation/accelerators/ocxl.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index ddcc58d01cfb..144595a80a1c 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -157,6 +157,16 @@ OCXL_IOCTL_GET_METADATA:
>     Obtains configuration information from the card, such at the size of
>     MMIO areas, the AFU version, and the PASID for the current context.
>   
> +OCXL_IOCTL_ENABLE_P9_WAIT:
> +
> +  Allows the AFU to wake a userspace thread executing 'wait'. Returns
> +  information to userspace to allow it to configure the AFU.

Note that this is only available on POWER9.

> +
> +OCXL_IOCTL_GET_PLATFORM:
> +
> +  Notifies userspace as to the platform the kernel believes we are on,
> +  which may differ from what userspace believes. Also reports on which CPU
> +  features which are usable from userspace.

The first sentence here doesn't seem to relate to anything that 
GET_PLATFORM actually does - afaict you're just passing flags which I 
suppose imply what the correct platform is, but really they're just 
feature flags?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
