Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-qe0-x231.google.com (mail-qe0-x231.google.com
 [IPv6:2607:f8b0:400d:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6EF992C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 16:30:46 +1000 (EST)
Received: by mail-qe0-f49.google.com with SMTP id s14so2531583qeb.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Oct 2013 23:30:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380863798.3564.12.camel@edumazet-glaptop.roam.corp.google.com>
References: <1380859875-31025-1-git-send-email-ast@plumgrid.com>
 <1380863798.3564.12.camel@edumazet-glaptop.roam.corp.google.com>
Date: Thu, 3 Oct 2013 23:30:41 -0700
Message-ID: <CAADnVQJq7r-e=vQBcvMqxEkFVzMjn=EaZ99j2boPj+YJBAhKxw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] fix unsafe set_memory_rw from softirq
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Daniel Borkmann <dborkman@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@plumgrid.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 3, 2013 at 10:16 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Thu, 2013-10-03 at 21:11 -0700, Alexei Starovoitov wrote:
>
> -static inline unsigned int sk_filter_len(const struct sk_filter *fp)
> +static inline unsigned int sk_filter_size(const struct sk_filter *fp,
> +                                         unsigned int proglen)
>  {
> -       return fp->len * sizeof(struct sock_filter) + sizeof(*fp);
> +       return max(sizeof(*fp),
> +                  offsetof(struct sk_filter, insns[proglen]));
>  }

indeed that's cleaner.
Like this then:
-static inline unsigned int sk_filter_len(const struct sk_filter *fp)
+static inline unsigned int sk_filter_size(unsigned int proglen)
 {
-       return fp->len * sizeof(struct sock_filter) + sizeof(*fp);
+       return max(sizeof(struct sk_filter),
+                  offsetof(struct sk_filter, insns[proglen]));
 }

testing it... will send v4 shortly
