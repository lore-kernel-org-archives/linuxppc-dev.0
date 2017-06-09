Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkwDB1MWPzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jun 2017 07:19:53 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v59LJE7s140469
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 17:19:51 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ayv5gubrv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Jun 2017 17:19:51 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 18:19:48 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v59LJiIX19726506
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 18:19:47 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v59LJbXN032463
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 18:19:38 -0300
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <87d1adihhk.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-security-module@vger.kernel.org, Jessica Yu <jeyu@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Howells <dhowells@redhat.com>,
 "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-ima-devel@lists.sourceforge.net,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 0/6] Appended signatures support for IMA appraisal
In-reply-to: <87d1adihhk.fsf@concordia.ellerman.id.au>
Date: Fri, 09 Jun 2017 18:19:19 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efusyi3s.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> On the OpenPOWER platform, secure boot and trusted boot are being
>> implemented using IMA for taking measurements and verifying signatures.
>
> I still want you to implement arch_kexec_kernel_verify_sig() as well :)

Yes, I will implement it! We are still working on loading the public
keys for kernel signing from the firmware into a kernel keyring, so
there's not much point in implementing arch_kexec_kernel_verify_sig
without having that first.

The same problem also affects IMA: even with these patches, new code
still neededs to be added to make IMA use the platform keys for kernel
signature verification.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
