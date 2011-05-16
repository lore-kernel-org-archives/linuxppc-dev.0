Return-Path: <paulus@ozlabs.org>
Date: Mon, 16 May 2011 11:07:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Message-ID: <20110516010757.GA2460@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<4DCBA345.6090006@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DCBA345.6090006@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2011 at 12:07:17PM +0300, Avi Kivity wrote:
> On 05/11/2011 01:44 PM, Paul Mackerras wrote:

> >--- a/include/linux/kvm.h
> >+++ b/include/linux/kvm.h
> >@@ -161,6 +161,7 @@ struct kvm_pit_config {
> >  #define KVM_EXIT_NMI              16
> >  #define KVM_EXIT_INTERNAL_ERROR   17
> >  #define KVM_EXIT_OSI              18
> >+#define KVM_EXIT_PAPR_HCALL	  19
> >
> >  /* For KVM_EXIT_INTERNAL_ERROR */
> >  #define KVM_INTERNAL_ERROR_EMULATION 1
> >@@ -264,6 +265,11 @@ struct kvm_run {
> >  		struct {
> >  			__u64 gprs[32];
> >  		} osi;
> >+		struct {
> >+			__u64 nr;
> >+			__u64 ret;
> >+			__u64 args[9];
> >+		} papr_hcall;
> >  		/* Fix the size of the union. */
> >  		char padding[256];
> >  	};
> 
> Please document this in Documentation/kvm/api.txt.

I'll add a description of the basic calling convention in the next
version of the patches.  The full description of all the possible
hypercalls is in the PAPR version 2.4 document (826 pages) on the
www.power.org website.  You have to become a power.org member to
download it, but membership is free for individual developers.

Paul.
