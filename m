Return-Path: <murzin.v@gmail.com>
Received: from mail-la0-x233.google.com (mail-la0-x233.google.com
 [IPv6:2a00:1450:4010:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 312392C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2013 05:59:08 +1000 (EST)
Received: by mail-la0-f51.google.com with SMTP id es20so5143357lab.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Sep 2013 12:59:02 -0700 (PDT)
Date: Tue, 3 Sep 2013 21:58:25 +0200
From: Vladimir Murzin <murzin.v@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc: bpf_jit: support MOD operation
Message-ID: <20130903195819.GA1971@hp530>
References: <1377643792-10327-1-git-send-email-murzin.v@gmail.com>
 <20130902174842.GA1866@hp530> <1378154750.3978.43.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
In-Reply-To: <1378154750.3978.43.camel@pasglop>
Cc: paulus@samba.org, dborkman@redhat.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 03, 2013 at 06:45:50AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-09-02 at 19:48 +0200, Vladimir Murzin wrote:
> > Ping
> > 
> > On Wed, Aug 28, 2013 at 02:49:52AM +0400, Vladimir Murzin wrote:
> > > commit b6069a9570 (filter: add MOD operation) added generic
> > > support for modulus operation in BPF.
> > >
> Sorry, nobody got a chance to review that yet. Unfortunately Matt
> doesn't work for us anymore and none of us has experience with the
> BPF code, so somebody (possibly me) will need to spend a bit of time
> figuring it out before verifying that is correct.
> 
> Do you have a test case/suite by any chance ?
> 
> Ben.
> 

Hi Ben!

Thanks for your feedback.

This patch is only compile tested. I have no real hardware, but I'll
probably bring up qemu ppc64 till end of the week...
Meanwhile, I've made simple how-to for testing. You can use it if you wish.
It is mainly based on the [1] and rechecked on x86-64.

1. get the tcpdump utility (git clone git://bpf.tcpdump.org/tcpdump)
2. get the libcap library (git clone git://bpf.tcpdump.org/libpcap)
2.1. apply patch for libcap [2] (against libcap-1.3 branch)
2.2. build libcap (./configure && make && ln -s libcap.so.1.3.0 libcap.so)
3. build tcpdump (LDFLAGS="-L/path/to/libcap" ./configure && make)
4. run 

# ./tcpdump -d "(ip[2:2] - 20) % 5 != 0 && ip[6] & 0x20 = 0x20"
(000) ldh [14]
(001) jeq #0x800 jt 2 jf 10
(002) ldh [18]
(003) sub #20
(004) mod #5
(005) jeq #0x0 jt 10 jf 6
(006) ldb [22]
(007) and #0x20
(008) jeq #0x20 jt 9 jf 10
(009) ret #65535
(010) ret #0

to get pseudo code (we are interested the most into line #4)

5. enable bpf jit compiler

# echo 2 > /proc/sys/net/core/bpf_jit_enable 

6. run

./tcpdump -nv "(ip[2:2] - 20) % 5 != 0 && ip[6] & 0x20 = 0x20"

7. check dmesg for lines starting with (output for x86-64 is provided as an example)

[ 3768.329253] flen=11 proglen=99 pass=3 image=ffffffffa003c000
[ 3768.329254] JIT code: ffffffffa003c000: 55 48 89 e5 48 83 ec 60 48 89 5d f8 44 8b 4f 60
[ 3768.329255] JIT code: ffffffffa003c010: 44 2b 4f 64 4c 8b 87 c0 00 00 00 0f b7 47 76 86
[ 3768.329256] JIT code: ffffffffa003c020: c4 3d 00 08 00 00 75 37 be 02 00 00 00 e8 9f 3e
[ 3768.329257] JIT code: ffffffffa003c030: 02 e1 83 e8 14 31 d2 b9 05 00 00 00 f7 f1 89 d0
[ 3768.329258] JIT code: ffffffffa003c040: 85 c0 74 1b be 06 00 00 00 e8 9f 3e 02 e1 25 20
[ 3768.329259] JIT code: ffffffffa003c050: 00 00 00 83 f8 20 75 07 b8 ff ff 00 00 eb 02 31
[ 3768.329259] JIT code: ffffffffa003c060: c0 c9 c3

8. make sure generated opcodes (JIT code) implement pseudo code form step 4.

Reference
[1] http://comments.gmane.org/gmane.linux.network/242456
[2] http://permalink.gmane.org/gmane.network.tcpdump.devel/5973

P.S.
I hope net people will corect me if I'm wrong there

Cheers
Vladimir Murzin

> > > This patch brings JIT support for PPC64
> > > 
> > > Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> > > ---
> > >  arch/powerpc/net/bpf_jit_comp.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > > index bf56e33..96f24dc 100644
> > > --- a/arch/powerpc/net/bpf_jit_comp.c
> > > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > > @@ -193,6 +193,28 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
> > >  				PPC_MUL(r_A, r_A, r_scratch1);
> > >  			}
> > >  			break;
> > > +		case BPF_S_ALU_MOD_X: /* A %= X; */
> > > +			ctx->seen |= SEEN_XREG;
> > > +			PPC_CMPWI(r_X, 0);
> > > +			if (ctx->pc_ret0 != -1) {
> > > +				PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
> > > +			} else {
> > > +				PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);
> > > +				PPC_LI(r_ret, 0);
> > > +				PPC_JMP(exit_addr);
> > > +			}
> > > +			PPC_DIVWU(r_scratch1, r_A, r_X);
> > > +			PPC_MUL(r_scratch1, r_X, r_scratch1);
> > > +			PPC_SUB(r_A, r_A, r_scratch1);
> > > +			break;
> > > +		case BPF_S_ALU_MOD_K: /* A %= K; */
> > > +#define r_scratch2 (r_scratch1 + 1)
> > > +			PPC_LI32(r_scratch2, K);
> > > +			PPC_DIVWU(r_scratch1, r_A, r_scratch2);
> > > +			PPC_MUL(r_scratch1, r_scratch2, r_scratch1);
> > > +			PPC_SUB(r_A, r_A, r_scratch1);
> > > +#undef r_scratch2
> > > +			break;
> > >  		case BPF_S_ALU_DIV_X: /* A /= X; */
> > >  			ctx->seen |= SEEN_XREG;
> > >  			PPC_CMPWI(r_X, 0);
> > > -- 
> > > 1.8.1.5
> > > 
> 
> 
