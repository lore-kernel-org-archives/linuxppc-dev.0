Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 047BA1402EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 10:04:30 +1000 (EST)
Message-ID: <1399334656.20388.69.camel@pasglop>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 06 May 2014 10:04:16 +1000
In-Reply-To: <87tx949u9d.fsf@linux.vnet.ibm.com>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <87tx949u9d.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-05 at 19:56 +0530, Aneesh Kumar K.V wrote:
> 
> Paul mentioned that BOOK3S always had DAR value set on alignment
> interrupt. And the patch is to enable/collect correct DAR value when
> running with Little Endian PR guest. Now to limit the impact and to
> enable Little Endian PR guest, I ended up doing the conditional code
> only for book3s 64 for which we know for sure that we set DAR value.

Only BookS ? Afaik, the kernel align.c unconditionally uses DAR on
every processor type. It's DSISR that may or may not be populated
but afaik DAR always is.

Cheers,
Ben.
