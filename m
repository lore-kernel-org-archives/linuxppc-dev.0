Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-qc0-x234.google.com (mail-qc0-x234.google.com
 [IPv6:2607:f8b0:400d:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ECEB02C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 17:46:53 +1000 (EST)
Received: by mail-qc0-f180.google.com with SMTP id a1so8028811qcx.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 00:46:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <51CA9C5E.1030609@redhat.com>
Date: Wed, 26 Jun 2013 09:46:38 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 29/45] kvm/vmx: Use get/put_online_cpus_atomic() to
 prevent CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625203043.16593.1600.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625203043.16593.1600.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Gleb Natapov <gleb@redhat.com>, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, kvm@vger.kernel.org, x86@kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 oleg@redhat.com, sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 25/06/2013 22:30, Srivatsa S. Bhat ha scritto:
> -	cpu = get_cpu();
> +	cpu = get_online_cpus_atomic();
>  	vmx_vcpu_load(&vmx->vcpu, cpu);
>  	vmx->vcpu.cpu = cpu;
>  	err = vmx_vcpu_setup(vmx);
>  	vmx_vcpu_put(&vmx->vcpu);
> -	put_cpu();
> +	put_online_cpus_atomic();

The new API has a weird name.  Why are you adding new functions instead
of just modifying get/put_cpu?

Paolo
