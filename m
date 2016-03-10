Return-Path: <jeyu@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA7091A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:25:40 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D6B3140B9E
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 11:25:39 +1100 (AEDT)
Date: Wed, 9 Mar 2016 19:25:32 -0500
From: Jessica Yu <jeyu@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Vojtech Pavlik <vojtech@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: livepatch: Add some basic LivePatch documentation
Message-ID: <20160310002532.GB22055@packer-debian-8-amd64.digitalocean.com>
References: <1457532106-30925-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1457532106-30925-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+++ Petr Mladek [09/03/16 15:01 +0100]:
>LivePatch framework deserves some documentation, definitely.
>This is an attempt to provide some basic info. I hope that
>it will be useful for both LivePatch producers and also
>potential developers of the framework itself.
>
>Signed-off-by: Petr Mladek <pmladek@suse.com>
>---
>
>This patch was motivated by the LivePatch port for PPC. The guys
>might want to document some PPC-specific limitations on top of it.
>
>I am sure that it is far from perfect. But I hope that it is
>an acceptable start that can be improved later. I hope that
>I did not write that many factual mistakes.
>
>I wrote only some generic info about the consistency model.
>I am not sure if we have agreed on some specification yet.
>
>I am sorry for grammar mistakes. I hope that some hairs will
>stay on your head if you are sensitive.

Thanks for getting us started on much-needed documentation. :-) It's a
good starting point.

I skimmed the document and it looks well organized. There are just some areas
that need more clarification. I just provided some suggested rewordings, though
they are subjective so you could either take them or leave them.

>
> Documentation/livepatch/livepatch.txt | 277 ++++++++++++++++++++++++++++++++++
> MAINTAINERS                           |   1 +
> 2 files changed, 278 insertions(+)
> create mode 100644 Documentation/livepatch/livepatch.txt
>
>diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
>new file mode 100644
>index 000000000000..28e8047abb61
>--- /dev/null
>+++ b/Documentation/livepatch/livepatch.txt
>@@ -0,0 +1,277 @@
>+=========
>+LivePatch
>+=========
>+
>+This document outlines basic information about kernel LivePatching.
>+
>+Table of Contents:
>+
>+1. Motivation
>+2. Kprobes, Ftrace, LivePatching
>+3. Consistency model
>+4. LivePatch life-cycle
>+   4.1. Registration
>+   4.2. Enabling
>+   4.3. Disabling
>+   4.4. Unregistration
>+5. Livepatch module
>+   5.1. New functions
>+   5.2. Metadata
>+   5.3. Module handling
>+6. Sysfs
>+7. Limitations
>+
>+
>+1. Motivation
>+=============
>+
>+There are situations when people are really reluctant to reboot a system.
>+It might be because the computer is in the middle of a complex scientific
>+computation. Or the system is busy handling customer requests in the high
>+season.
>+
>+On the other hand, people also want to keep the system stable and secure.
>+This is where LivePatch infrastructure comes handy.

>It allows to redirect selected function calls to a fixed
>implementation without rebooting the system.

It allows selected function calls to be redirected to a fixed
implementation without requiring a system reboot.

>+
>+
>+2. Kprobes, Ftrace, LivePatching
>+================================

>+Linux kernel has more ways how to redirect an existing code into a new one.
>+It happens with kernel probes, function tracing, and LivePatching:

There are multiple mechanisms in the Linux kernel that are directly related to
redirection of code execution; namely: kernel probes, function tracing, and
livepatching:

>+
>+  + The kernel probes are the most generic way. The code can be redirected
>+    by putting an interrupt instruction instead of any instruction.
>+
>+  + The function tracer calls the code from a predefined location that is
>+    close the function entry. The location is generated by the compiler,
>+    see -pg gcc option.
>+
>+  + LivePatching typically needs to redirect the code at the very beginning
>+    of the function entry before the function parameters or the stack
>+    are anyhow muffled.
>+
>+All three approaches need to modify the existing code at runtime. Therefore
>+they need to be aware of each other and do not step over othres' toes. Most
>+of these problems are solved by using the dynamic ftrace framework as a base.
>+A Kprobe is registered as a ftrace handler when the function entry is probed,
>+see CONFIG_KPROBES_ON_FTRACE. Also an alternative function from a live patch
>+is called from a custom ftrace handler. But there are some limitations,
>+see below.
>+
>+
>+3. Consistency model
>+====================
>+
>+Functions are there for a reason. They take some input parameters, get or
>+release locks, read, process, and even write some data in a defined way,
>+have return values. By other words, each function has a defined semantic.
>+
>+Many fixes do not change the semantic of the modified functions. For example,
>+they add a NULL pointer or a boundary check, fix a race by adding a missing
>+memory barrier, or add some locking about a critical section. Most of these
>+changes are self contained and the function present itself the same way
>+to the rest of the system. In this case, the functions might be updated
>+independently one by one.
>+
>+But there are more complex fixes. For example, a patch might change
>+ordering of locking in more functions at the same time. Or a patch
>+might exchange meaning of some temporary structures and update
>+all the relevant functions. In this case, the affected unit
>+(thread, whole kernel) need to start using all new versions of
>+the functions at the same time. Also the switch must happen only
>+when it is safe to do so, e.g. when the affected locks are released,
>+the data using the modified structures are empty.
>+
>+The theory about how to apply functions a safe way is rather complex.
>+The aim is to define a so-called consistency model. It means to define
>+conditions when the new implementation could be used so that the system
>+stays consistent. The theory is not yet finished. See the discussion at
>+http://thread.gmane.org/gmane.linux.kernel/1823033/focus=1828189
>+
>+The current implementation supports the easiest scenario that
>+is sufficeint for the most common fixes. See the limitations below.
>+
>+
>+4. LivePatch life-cycle
>+=======================
>+
>+LivePatching defines four basic operations that define the life cycle
>+of each live patch.
>+
>+4.1. Registration
>+-----------------
>+
>+Each patch has to be registered using klp_register_patch().
>+
>+Here the patch is added into the list of known patches. The addresses
>+of the patched functions are found according to their names.
>+Relocations are applied. The relevant entries are created under
>+/sys/kernel/livepatch/<name>.
>+
>+
>+4.2. Enabling
>+-------------
>+
>+Registered patches might be enabled either by calling klp_enable_patch() or
>+by writing '1' to /sys/kernel/livepatch/<name>/enabled.

>+At this stage, an universal ftrace handler is registered for all newly patched
>+functions with a function-specific ftrace_ops structure. The structure points
>+to a list of struct klp_func, see func_stack. This way the same function
>+can be patched more times. The last variant from the func_stack is used.

I think "The structure" is a little ambiguous, and it's not quite clear what
func_stack is. How about an explanation like the following:

Each patched function is associated with a single klp_ops structure that points
to a stack (see field `func_stack` in struct klp_ops) of different versions of
replacement functions. The order of the stack depends on when the replacement
function was enabled, with the most recently enabled replacement function (and
therefore the currently active one) on top of the stack. Thus a function can be
patched multiple times, and the func_stack list keeps track of which
replacement function was the most recently enabled one.

>+Note that we could enable patches in a different order than they are
>+registered. The actually used function is defined by the order in
>+the func_stack list.

The replacement function that is currently active is defined by the order of
the func_stack list.

>+
>+4.3. Disabling
>+--------------
>+
>+Enabled patches might get disabled either by calling klp_disable_patch() or
>+by writing '0' to /sys/kernel/livepatch/<name>/enabled.

>+Here all the struct klp_functions are removed from the appropriate
>+ftrace_ops. The ftrace handler is unregistered when the func_stack
>+list gets empty.

Here all the functions (struct klp_func) associated with the to-be-disabled
patch are removed from the corresponding ftrace_ops. (I just reworded it to
emphasize that not *all* the functions are removed from the function's ftrace
ops, just the ones that are associated with the to-be-disabled patch)

>+Patches must be disabled in the exactly revese order in which they were
>+enabled. It makes the problem and the implementation easier.
>+
>+
>+4.4. Unregistration
>+-------------------
>+
>+Disabled patched might be unregistered by calling klp_unregister_patch().
>+
>+At this stage, all the relevant sys-fs entries are removed and the patch
>+is removed from the list of known patches.

It may be confusing for new livepatch users to differentiate between
register vs. enable and disable vs. unregister, so perhaps it would be good
to put a blurb differentiating those actions here somewhere.

>+
>+5. Livepatch module
>+===================
>+
>+Live patches are distributed using kernel modules, see
>+samples/livepatch/livepatch-sample.c.
>+
>+The module includes a new implementation of functions that we want
>+to replace. In addition, it defines some structures describing what
>+functions are replaced. Finally, there is a code for registering,
>+enabling, and unregistering the patch.
>+
>+
>+5.1. New functions
>+------------------
>+
>+New versions of functions are typically just copied from the fixed sources.
>+A good practice is to add a prefix to the names so that they can be
>+distinguished from the original ones, e.g. in a backtrace. Also it
>+is usually enough to have a local visibility (static).
>+
>+The patch contains only functions that are really modified. But they might
>+want to access functions or data with local visibility from the original
>+source.c file. This can be solved by relocation information. FIXME:
>+The support and documentation for relocations is still in progress.
>+
>+
>+5.2. Metadata
>+------------
>+
>+The patch is described by several structures that split the information
>+into three levels:
>+
>+  + struct klp_patch is defined for each patched function. It includes
>+    a name (string) of the original function, optionaly the position

s/optionaly/optionally

>+    of the symbol within an object, and a name (pointer) to the new
>+    function implementation. The old function will be later found via
>+    kallsyms at runtime. The new function is defined in the same
>+    source file.
>+
>+  + struct klp_object defines an array of patched functions (struct
>+    klp_patch) in the same object. Where object is either vmlinux (NULL)
>+    or a module name. It helps to group and handle functions for each
>+    object together. Note that patched modules might be loaded later
>+    then the patch itself and the relevant functions might be patched
>+    only when they are available.
>+
>+  + struct klp_patch defines an array of patched objects (struct
>+    klp_object). It allows to handle all patched functions consistently
>+    and synchronously. The whole patch is applied only when all available
>+    symbols can be patched. If a more complex consistency model is supported
>+    then a selected unit (thread, kernel as a whole) will see the new code
>+    from the entire patch only when they are in a safe state.
>+
>+
>+5.3. Module handling
>+-------------------
>+
>+The live patch is typically registered and enabled when the module
>+is loaded. The reverse operations are called when the module
>+is being removed.
>+
>+IMPORTANT: Livepatch modules could not be removed at the moment.
>+See the limitations below.
>+
>+
>+6. Sysfs
>+========
>+
>+Information about the registered patches might be found under
>+/sys/kernel/livepatch. The patches could be enabled and disabled
>+by writing there.
>+
>+See Documentation/ABI/testing/sysfs-kernel-livepatch for more details.
>+
>+
>+7. Limitations
>+==============
>+
>+The initial Livepatch implementation has several limitations:
>+
>+  + The modules with LivePatches could not be removed without forcing
>+    at the moment.

You mean the livepatch modules, not the modules that livepatch patches, right?
Let's make that a bit clearer :-)

>+    The problem is how to detect if anyone is still using (sleeping inside)
>+    a code from the patch. It will get most likely solved once a more complex
>+    consistency model is supported. The idea is that a safe state for patching
>+    should also mean a safe state for removing the patch.
>+
>+
>+  + Only functions that can be traced could be patched.
>+
>+    Livepatch is based on the dynamic ftrace. In particular, functions
>+    implementing ftrace or the livepatch ftrace handler could not be patched.
>+    Otherwise, you would end up in an infinite loop. A potential mistake
>+    is prevented by marking the problematic functions by "notrace".
>+
>+
>+  + Livepatch works reliably only when the dynamic ftrace is located at
>+    the very beginning of the function.
>+
>+    The function need to be redirected before the stack or the function
>+    parameters are muffled any way. For example, LivePatch requires
>+    using -fentry on x86_64.

We should be specific and mention that we're talking about the gcc
option -fentry that's required.

>+
>+
>+  + The patch must not change the semantic of the patched functions.
>+
>+    The current implementation guarantees only that either the old
>+    or the new function is called. The functions are patched one
>+    by one. It means that the patch must _not_ change the semantic
>+    of the function.
>+
>+
>+  + Kretprobes using the ftrace framework conflict with the patched functions.
>+
>+    Both Kretprobes and LivePatches use a ftrace handler that modifies
>+    the return address. The first user wins. Either the probe or the patch
>+    is rejected when the handler is already in use by the other.
>+
>+
>+  + Kprobes in the original function are ignored when the code is redirected
>+    to the new implementation.
>+
>+    There is a work in progress to add warnings about this situations.
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 4029c63d8a7d..0e7049688862 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -6590,6 +6590,7 @@ F:	kernel/livepatch/
> F:	include/linux/livepatch.h
> F:	arch/x86/include/asm/livepatch.h
> F:	arch/x86/kernel/livepatch.c
>+F:	Documentation/livepatch/
> F:	Documentation/ABI/testing/sysfs-kernel-livepatch
> F:	samples/livepatch/
> L:	live-patching@vger.kernel.org
>-- 
>1.8.5.6
>
