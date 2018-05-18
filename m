Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nY5L4nhyzF2Db
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 02:09:06 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id a8-v6so14963068wmg.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 09:09:06 -0700 (PDT)
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 18 May 2018 09:08:42 -0700
Message-ID: <CAADnVQKzBdSLNXEmd47xTv15caXWp6JTCAnHD3n7Trbr9BZq4A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/6] tools: bpf: sync bpf uapi header
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Network Development <netdev@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jakub Kicinski <jakub.kicinski@netronome.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2018 at 5:50 AM, Sandipan Das
<sandipan@linux.vnet.ibm.com> wrote:
> Syncing the bpf.h uapi header with tools so that struct
> bpf_prog_info has the two new fields for passing on the
> addresses of the kernel symbols corresponding to each
> function in a JITed program.
>
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  tools/include/uapi/linux/bpf.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index d94d333a8225..040c9cac7303 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -2188,6 +2188,8 @@ struct bpf_prog_info {
>         __u32 xlated_prog_len;
>         __aligned_u64 jited_prog_insns;
>         __aligned_u64 xlated_prog_insns;
> +       __aligned_u64 jited_ksyms;
> +       __u32 nr_jited_ksyms;
>         __u64 load_time;        /* ns since boottime */
>         __u32 created_by_uid;
>         __u32 nr_map_ids;

this breaks uapi.
New fields can only be added to the end.
