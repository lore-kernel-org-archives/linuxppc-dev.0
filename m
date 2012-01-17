Return-Path: <paulus@ozlabs.org>
Date: Tue, 17 Jan 2012 22:31:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 1/2] KVM: PPC: Book3S HV: Make virtual processor area
 registration more robust
Message-ID: <20120117113140.GA9093@bloggs.ozlabs.ibm.com>
References: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
 <20111220102257.GC5626@bloggs.ozlabs.ibm.com>
 <1A57B98F-A4C7-457D-A52A-4F67D5902E32@suse.de>
 <20120117055654.GB9170@drongo>
 <6D049B19-8A91-445A-9FBB-E4851D4F586E@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6D049B19-8A91-445A-9FBB-E4851D4F586E@suse.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 17, 2012 at 10:27:26AM +0100, Alexander Graf wrote:

> The thing I was getting at was not the map during the lifetime, but
> the map during registration. Currently we have:
> 
> 1) Set VPA to x
> 2) Assign feature y to VPA
> 3) Use VPA
> 
> 1 and 2 are the slow path, 3 occurs more frequently. So we want 3 to
> be fast. 1 and 2 don't matter that much wrt performance.
> 
> You are currently mapping the VPA at /, which gets you into this
> map/unmap mess trying to free the previous mapping. If you moved the
> map to step 2 and only stored the GPA at step 1, all map+unmap
> operations except for final unmaps would be in one spot, so you
> wouldn't need to construct this big complex state machine.

That might simplify things - I'll try it and see.  The worry with
doing the map/pin at 2 is that if anything goes wrong we no longer
have the opportunity to return an error for the H_REGISTER_VPA call,
so I'll have to at least do some checking in 1, leading to possibly
more code overall.

Paul.
