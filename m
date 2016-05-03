Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhKD26B2zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:07:11 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 7811620225
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 13:07:09 +0000 (UTC)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
 [209.85.161.171])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 82E8020270
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 13:07:08 +0000 (UTC)
Received: by mail-yw0-f171.google.com with SMTP id t10so19483286ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 May 2016 06:07:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
References: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 3 May 2016 08:06:48 -0500
Message-ID: <CAL_JsqJCkrjkDDwqznCPbiDVrQUr4pQgHs_YcFVm04-j5XZREA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/of: Add check for null property in
 of_remove_property()
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 28, 2016 at 12:34 AM, Suraj Jitindar Singh
<sjitindarsingh@gmail.com> wrote:
> The validity of the property input argument to of_remove_property() is
> never checked within the function and thus it is possible to pass a null
> value. It happens that this will be picked up in __of_remove_property()
> as no matching property of the device node will be found and thus an
> error will be returned, however once again there is no explicit check
> for a null value. By the time this is detected 2 locks have already been
> acquired which is completely unnecessary if the property to remove is
> null.
>
> Add an explicit check in the function of_remove_property() for a null
> property value and return -ENODEV in this case, this is consistent with
> what the previous return value would have been when the null value was
> not detected and passed to __of_remove_property().
>
> By moving an explicit check for the property paramenter into the
> of_remove_property() function, this will remove the need to perform this
> check in calling code before invocation of the of_remove_property()
> function.
>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

For both patches:

Acked-by: Rob Herring <robh@kernel.org>
