Return-Path: <tommusta@gmail.com>
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com
 [IPv6:2607:f8b0:4001:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B84B2C00BB
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Oct 2013 05:52:14 +1000 (EST)
Received: by mail-ie0-f176.google.com with SMTP id as1so6594173iec.21
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Oct 2013 12:52:12 -0700 (PDT)
Message-ID: <524DCAE6.5090601@gmail.com>
Date: Thu, 03 Oct 2013 14:52:06 -0500
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/9][v5] powerpc: implement is_instr_load_store().
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <20131003053519.GC17237@concordia> <20131003190325.GB21561@us.ibm.com>
In-Reply-To: <20131003190325.GB21561@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/3/2013 2:03 PM, Sukadev Bhattiprolu wrote:
> Michael Ellerman [michael@ellerman.id.au] wrote:
<snip>
> |
> |         if (lower == 6)
> |             if (upper <= 1)
> |                 return true;
> |             return false;
> v
Note that this case covers the lvsl/lvsr instructions, which, despite their
names are not actually loads.  So you could eliminate this check and do
just a little bit better.
