Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C712D2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 23:13:17 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 18:43:15 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 031D8125803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:43:28 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RDFXkX16973904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:45:33 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RDD9fT003846
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:43:10 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 09/11] kvm: simplify processor compat check
In-Reply-To: <E5A81672-864D-4E33-B15A-5F6927CC7C13@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <E5A81672-864D-4E33-B15A-5F6927CC7C13@suse.de>
Date: Fri, 27 Sep 2013 18:43:09 +0530
Message-ID: <87r4ca9zmi.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 Gleb Natapov <gleb@redhat.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> Missing patch description.
>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> I fail to see how this really simplifies things, but at the end of the
> day it's Gleb's and Paolo's call.

will do. It avoid calling 

	for_each_online_cpu(cpu) {
		smp_call_function_single() 

on multiple architecture.

We also want to make the smp call function a callback of opaque. Hence
this should be made arch specific. 

int kvm_arch_check_processor_compat(void *opaque)
{
	int r,cpu;
	struct kvmppc_ops *kvm_ops = (struct kvmppc_ops *)opaque;
	for_each_online_cpu(cpu) {
		smp_call_function_single(cpu,
					 kvm_ops->check_processor_compat,
					 &r, 1);
		if (r < 0)
			break;
	}
	return r;
}

against

-	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu,
-				kvm_arch_check_processor_compat,
-				&r, 1);
-		if (r < 0)
-			goto out_free_1;
-	}
+
+	r = kvm_arch_check_processor_compat(opaque);
+	if (r < 0)
+		goto out_free_1;



>
> Which brings me to the next issue: You forgot to CC kvm@vger on your
> patch set. Gleb and Paolo don't read kvm-ppc@vger. And they shouldn't
> have to. Every kvm patch that you want review on or that should get
> applied needs to be sent to kvm@vger. If you want to tag it as PPC
> specific patch, do so by CC'ing kvm-ppc@vger.

Will do in the next update

-aneesh
