Return-Path: <B18196@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0138.outbound.protection.outlook.com [157.56.110.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39AEA1A086D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 02:10:33 +1000 (AEST)
Message-ID: <5579B2FC.4010008@freescale.com>
Date: Thu, 11 Jun 2015 19:10:36 +0300
From: Cristian Stoica <cristian.stoica@freescale.com>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: <horia.geanta@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc: support sizes greater than an unsigned long
References: <1431620684-20123-1-git-send-email-cristian.stoica@freescale.com>
 <1431683064-29584-1-git-send-email-cristian.stoica@freescale.com>
 <55799E38.1000004@freescale.com> <20150611153835.GB5058@kroah.com>
In-Reply-To: <20150611153835.GB5058@kroah.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2015 06:38 PM, Greg KH wrote:
> On Thu, Jun 11, 2015 at 05:42:00PM +0300, Cristian Stoica wrote:
> 
> Why?
> 

This patch matches the input argument "size" of ioremap() with the output of request_mem_region() (which is
resource_size_t).
Since the latter is used as input to the former, the types should match (even though mapping more than 4G is not usually
expected). There are a lot of such differences in the code and this is an attempt to reduce that.

Cristian S.
