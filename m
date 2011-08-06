Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E3AF1E4.90407@infradead.org>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-3-git-send-email-a.heider@gmail.com>
	<4E39CBFC.2010501@infradead.org> <4E39F386.8020403@marcansoft.com>
	<4E3AF1E4.90407@infradead.org>
Date: Sat, 6 Aug 2011 13:50:58 +0200
Message-ID: <CAHsu+b_hNdLhT1_2q-jxnaWsfOVnCNdo6YTcC0kb1Qhy5v8cvg@mail.gmail.com>
Subject: Re: [PATCH 02/15] [PS3] Get lv1 high memory region from devtree
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 4, 2011 at 9:24 PM, Geoff Levand <geoff@infradead.org> wrote:
> Also, it needs to be considered that a lot of kernels are out
> there will be confused if started with high mem already allocated.

True, but is there anything we can do about that?
Isn't is okay to tell users of first stage boot loaders utilizing this
mechanism that whatever steps their boot chain contains has to support
this highmem pass over? As far as I can tell all current loaders won't
be affected by this patch.
When a user wants to chain a loader with this mechanism with
petitboot, he needs a petitboot coming with a kernel containing this
feature, and can then kexec whatever contains it too.

>> Using the lv1 repo is an option, but does it make sense? It's even less
>> standard than a FDT and we'd have to put both the region1 location and
>> the initrd location in there (there's no point to maintaining highmem if
>> you aren't going to use it).
>>
>> FWIW, the lv1 repo writing hypercalls are unused and undocumented.
>
> The hcalls to create, write, and delete nodes are known, but I don't
> recall if I verified they work:
>
> =A0http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;f=3Darch/powerpc/include/asm/lv1call.h;hb=3DHEAD#l265
>
> #92 should be named lv1_write_repository_node.
>
> You can only modify the repo for your lpar, so:
>
> =A0lv1_{create,write}_repository_node(n1, n2, n3, n4, v1, v2);
> =A0lv1_delete_repository_node(n1, n2, n3, n4);

I tried this and it indeed works - I can pass over the highmem info
just fine using repository nodes.
If there is a chance that another OS might require this highmem pass
over then I agree that using the repository makes more sense.

I can prepare a patch for that, replacing this one. Any suggestions on
which nodes to use?
For a test run I used:
  FIELD_FIRST("bi", 0),
  FIELD("highmem", 0),
  FIELD("address", 0),
  0
and
  FIELD_FIRST("bi", 0),
  FIELD("highmem", 0),
  FIELD("size", 0),
  0

Regards,
Andre
