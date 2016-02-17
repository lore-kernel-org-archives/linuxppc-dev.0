Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-x22c.google.com (mail-yw0-x22c.google.com
 [IPv6:2607:f8b0:4002:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA5351A0597
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 01:54:14 +1100 (AEDT)
Received: by mail-yw0-x22c.google.com with SMTP id g127so14700066ywf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 06:54:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-42-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-42-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 17 Feb 2016 08:53:51 -0600
Message-ID: <CAL_JsqKWokaUSgf8dfi7Ao_hrKCMf1LYS_ubd=Z=_+d6ehD9Jw@mail.gmail.com>
Subject: Re: [PATCH v8 41/45] drivers/of: Avoid recursively calling
 unflatten_dt_node()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
 Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> In current implementation, unflatten_dt_node() is called recursively
> to unflatten device nodes in FDT blob. It's stress to limited stack
> capacity, especially to adopt the function to unflatten device sub-tree
> that possibly has multiple root nodes. In that case, we runs out of
> stack and the system can't boot up successfully.
>
> In order to reuse the function to unflatten device sub-tree, this avoids
> calling the function recursively, meaning the device nodes are unflattened
> in one call on unflatten_dt_node(): two arrays are introduced to track the
> parent path size and the device node of current level of depth, which will
> be used by the device node on next level of depth to be unflattened. All
> device nodes in more than 64 level of depth are dropped and hopefully,
> the system can boot up successfully with the partial device-tree.
>
> Also, the parameter "poffset" and "fpsize" are unused and dropped and the
> parameter "dryrun" is figured out from "mem == NULL". Besides, the return
> value of the function is changed to indicate the size of memory consumed by
> the unflatten device tree or error code.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 122 +++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 74 insertions(+), 48 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
