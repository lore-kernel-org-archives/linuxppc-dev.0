Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 6EDFC140084
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 May 2014 04:23:39 +1000 (EST)
Date: Fri, 16 May 2014 11:26:57 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Himangi Saraogi <himangi774@gmail.com>
Subject: Re: question about hvc_opal.c
Message-ID: <20140516182657.GA15475@kroah.com>
References: <CAB78YHynbQ=cR-jDTHpwwVGgDO24fjXETO1Zp88QD=Vkjf+6GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAB78YHynbQ=cR-jDTHpwwVGgDO24fjXETO1Zp88QD=Vkjf+6GQ@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 16, 2014 at 11:34:13PM +0530, Himangi Saraogi wrote:
> Hi,
>  
> In function hvc_opal_probe I find :
> 
>         hp = hvc_alloc(termno, 0, ops, MAX_VIO_PUT_CHARS);
>         if (IS_ERR(hp))
>                 return PTR_ERR(hp);
> 
> Earlier, hpc_opal_privs[termno] is assigned pv which is allocated using
> kzalloc. Shouldn't there be a kfree(pv) and the array element (which is global)
> be made NULL before the return. Also, if array element is set to NULL on the
> failure, then some cleanup must be done to undo the effect of hvc_instantiate
> as well. Please let me know if the change is desirable.

Sounds reasonable, please send a patch.
