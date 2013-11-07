Return-Path: <michael.neuling@gmail.com>
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <527A183F.7030500@linux.vnet.ibm.com>
References: <1383640732-21449-1-git-send-email-felix@linux.vnet.ibm.com>
 <11438.1383718966@ale.ozlabs.ibm.com>
 <527A183F.7030500@linux.vnet.ibm.com>
Date: Thu, 7 Nov 2013 13:10:38 +1100
Message-ID: <CAEjGV6yjBdD5vjLE0tVKJv5EBS8OhkLNmquz0wL8oYk_REETBA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: memcpy optimization for 64bit LE
From: Michael Neuling <mikey@neuling.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OK, can you add that and/or maybe antons description to the patch changelog?

Mikey

On Wed, Nov 6, 2013 at 9:21 PM, Philippe Bergheaud
<felix@linux.vnet.ibm.com> wrote:
> Michael Neuling wrote:
>>
>> Philippe Bergheaud <felix@linux.vnet.ibm.com> wrote:
>>
>>
>>> Unaligned stores take alignment exceptions on POWER7 running in
>>> little-endian.
>>> This is a dumb little-endian base memcpy that prevents unaligned stores.
>>> It is replaced by the VMX memcpy at boot.
>>
>>
>>
>> Is this any faster than the generic version?
>
>
> The little-endian assembly code of the base memcpy is similar to the code
> emitted by gcc when compiling the generic memcpy in lib/string.c, and runs
> at the same speed.
> However, a little-endian assembly version of the base memcpy is required (as
> opposed to a C version), in order to use the self-modifying code
> instrumentation system.
> After the cpu feature CPU_FTR_ALTIVEC is detected at boot, the slow base
> memcpy is nop'ed out, and the fast memcpy_power7 is used instead.
>
> Philippe
>
