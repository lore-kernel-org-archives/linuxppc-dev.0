Return-Path: <martin@hinner.info>
Received: from mail-ve0-f175.google.com (mail-ve0-f175.google.com
 [209.85.128.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3ECB2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2013 00:54:59 +1000 (EST)
Received: by mail-ve0-f175.google.com with SMTP id oy10so1177813veb.34
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 07:54:55 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 24 Aug 2013 16:54:55 +0200
Message-ID: <CAPVwjkzkuw4cbo9YxnsskdoAda-k+Gb5sdVEJiZTVAD1nR5OOg@mail.gmail.com>
Subject: Loading kernel on MPC86x
From: Martin Hinner <martin@hinner.info>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

  I am trying to load kernel 2.6.39 on MPC86x-based Cisco 8xx router
(I need development platform for another embedded project and this
router was first suitable device I have).

So far I have:

- built crosscompiler
- created simple bootloader based on CILO code that can load ELF
(zImage) into memory, relocate and start it
- Modified Linux kernel arch/powerpc/boot directory so as it can
decompress kernel into memory and start it (__start gets executed)
- Created dts for the device (arch/powerpc/boot/main.c is making
printf via correct device without any hacks)

Most of tasks were accomplished by creating temporary debug output to
cpm-uart and finding problems step-by-step, however I am a bit stuck
with kernel now and I would appreciate some help from someone who has
already done similar task.

Hardware info: The MPC86x has 32MB SDRAM located at 0x00000 and
0x80000000 (I have not checked how this is done but it looks like it's
alias as both memory regions have the same data). IMMR is 0xff000000,
ROM is at 0xfff00000. Initial stack is in first 64kB (I left it as
Cisco rommon has set it up).

I had to modify arch/powerpc/boot/main.c so as it loads kernel to a
different location than 0 and does not overwrite rommon's exception
vectors & stack.

arch/powerpc/boot/main.c starts succesfully kernel (I can see debug
output produced by modified '__start' at
arch/powerpc/kernel/head_8xx.S). Unfortunately call to "bl
initial_mmu" fails (there is no exception that rommon catches,
processor just freezes and as I do not have BDM attached to it I have
no idea what is going wrong).

My feeling is that I should load vmlinux to address 0 as there is no
relocation code anywhere. Is this correct? I can live with it (stack
will be relocated in my bootloader, but before I start doing this work
(more than stack relocation is involved) I would like to make sure it
is really my problem).

Second, I would like to ask what else do I have to set-up before
jumping to arch/powerpc/kernel/head_8xx.S ; is vmlinux sitting at
0x00000 and "temporary" stack at safe place (end of mem) enough ? How
about interrupts ? What if some of them were enabled by Cisco
startup/rommon ?

Do I understand correctly that
arch/powerpc/kernel/head_8xx.S:initial_mmu (and then real mm handler)
sets-up MMU so as I can always access IMMR region and print debug
characters on console? (I am sorry I am not yet familiar with MPC8xx
MMU so the code is a bit confusing for me).

I do not understand how kernel base 0xC0000000 works; kernel is
normally loaded at 0, however all references go to 0xC0000000. Does
initial_mmu set-up "mapping" from 0xC0000000 to 0x00000 or do I miss
anything? When switch from 0 to 0xC0000000 happens?

Maybe a link to document describing how kernel on PowerPC starts would
clarify all my question, but all I have found is focused on using
existing bootloaders (U-Boot) with no detailed description ...

Thank you,

Martin
