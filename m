Return-Path: <lars@metafoo.de>
Received: from smtp-out-179.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by lists.ozlabs.org (Postfix) with ESMTP id 15FDA1A0CED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 07:06:45 +1100 (AEDT)
Message-ID: <54BD62B5.7050205@metafoo.de>
Date: Mon, 19 Jan 2015 21:01:57 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/19/2015 07:55 PM, Wolfram Sang wrote:
[...]
>
> Let's get rid of this code before really nobody knows/understands
> anymore what this was for and if it has a subtle use.

Getting rid of this is the right thing, cause it's just not how it should be 
done, but unfortunately it is not as simple as this. The problem is that the 
adapter is typically embedded in the parent device's state struct. This state 
struct is typically freed directly after calling i2c_del_adapter(). If there is 
still something holding a reference to the adapter this will result in a use 
after free. To do this properly i2c_add_adapter() needs to be changed to 
i2c_alloc_adapter() that returns a pointer to a newly allocated adapter. 
i2c_free_adapter() will then only drop a reference to the adapter, but not free 
any memory. Once the last reference has been removed the memory can then be 
freed in the release callback.

The other issue is as long as something has a reference to the adapter they can 
run operations on the adapter. So freeing the adapter also has to make sure 
that any further operations that are performed on the adapter do no longer call 
into the device specific ops, but rather returns -ENODEV, or similar.

- Lars
