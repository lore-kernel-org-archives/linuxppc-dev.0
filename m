Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E732A2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 21:24:48 +1100 (EST)
Received: from christians-pro.lan
 (ppp-93-104-90-71.dynamic.mnet-online.de [93.104.90.71])
 by smtp.strato.de (RZmta 32.17 DYNA|AUTH)
 with (TLSv1:DHE-RSA-AES256-SHA encrypted) ESMTPSA id R02824q0MAINkT7
 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 22 Jan 2014 11:18:23 +0100 (CET)
Message-ID: <52DF9AEF.30900@xenosoft.de>
Date: Wed, 22 Jan 2014 11:18:23 +0100
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 67811] PASEMI: Kernel 3.13.0 doesn't boot with a PA6T cpu
References: <1388264507-5100-1-git-send-email-olof@lixom.net>
 <CAOesGMhHw-G-T7ZfNsVU92ftOucCNe9shNJtA7SWzqX=dQBQng@mail.gmail.com>
 <CAOesGMgsY0R6KBXXH_ibTBYb1i_auWESwnoDkvi-esb58Pc+2A@mail.gmail.com>
 <20140103081219.GA10233@quad.lixom.net> <1389154189.2076.5.camel@concordia>
 <1389154706.4672.21.camel@pasglop> <20140108174828.GA16830@quad.lixom.net>
 <52CDC12F.5030407@xenosoft.de> <52D6E829.1050504@xenosoft.de>
 <52D6E89C.7010407@xenosoft.de> <52D6E928.7050307@xenosoft.de>
In-Reply-To: <52D6E928.7050307@xenosoft.de>
Content-Type: multipart/alternative;
 boundary="------------090604010403020608090404"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090604010403020608090404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Thanks a lot for your effort to solve the boot problems. Unfortunately, 
this patch doesn't work for the Nemo board. I need the patch created by 
Olof Johansson.

diff -rupN linux-3.13/arch/powerpc/kernel/head_64.S 
linux-3.13-nemo/arch/powerpc/kernel/head_64.S
--- linux-3.13/arch/powerpc/kernel/head_64.S    2014-01-05 
00:12:14.000000000 +0100
+++ linux-3.13-nemo/arch/powerpc/kernel/head_64.S    2014-01-05 
23:06:13.001618802 +0100
@@ -69,6 +69,13 @@ _GLOBAL(__start)
      /* NOP this out unconditionally */
  BEGIN_FTR_SECTION
      FIXUP_ENDIAN
+/* Hack for PWRficient platforms: Due to CFE(?) bug, the 64-bit
+ * word at 0x8 needs to be set to 0. Patch it up here once we're
+ * done executing it (we can be lazy and avoid invalidating
+ * icache)
+ */
+li    r0,0
+std    0,8(0)
      b    .__start_initialization_multiplatform
  END_FTR_SECTION(0, 1)

Is it possible to integrate Olof's patch into the kernel sources?

All the best,

Christian

Am 15.01.14 21:01, schrieb Christian Zigotzky:
> author 	Linus Torvalds <torvalds@linux-foundation.org> 	2014-01-13 
> 03:59:05 (GMT)
> committer 	Linus Torvalds <torvalds@linux-foundation.org> 	2014-01-13 
> 03:59:05 (GMT)
> commit 	a6da83f98267bc8ee4e34aa899169991eb0ceb93 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93> 
> (patch 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/patch/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93>) 
>
> tree 	84c228e0a87475dbdb0f72621c137cce8253131b 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93> 
>
> parent 	061f49ec2d722f485237870f04544d8bec15a778 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=061f49ec2d722f485237870f04544d8bec15a778> 
> (diff 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93&id2=061f49ec2d722f485237870f04544d8bec15a778>) 
>
> parent 	10348f5976830e5d8f74e8abb04a9a057a5e8478 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=10348f5976830e5d8f74e8abb04a9a057a5e8478> 
> (diff 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93&id2=10348f5976830e5d8f74e8abb04a9a057a5e8478>) 
>
>
> Merge branch 'merge' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc
> Pull powerpc fix from Ben Herrenschmidt: "Here's one regression fix 
> for 3.13 that I would appreciate if you could still pull in. It was an 
> "interesting" one to debug, basically it's an old bug that got 
> somewhat "exposed" by new code breaking the boot on PA Semi boards 
> (yes, it does appear that some people are still using these!)" * 
> 'merge' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc: 
> powerpc: Check return value of instance-to-package OF call
> Diffstat 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93>
> -rw-r--r-- 	arch/powerpc/kernel/prom_init.c 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/arch/powerpc/kernel/prom_init.c?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93> 
> 	22 	
>
> 	
> 	
>
> 1 files changed, 13 insertions, 9 deletions
> diff --git a/arch/powerpc/kernel/prom_init.c 
> b/arch/powerpc/kernel/prom_init.c
> index cb64a6e..078145a 100644
> --- a/arch/powerpc/kernel/prom_init.c 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/prom_init.c?id=061f49ec2d722f485237870f04544d8bec15a778>
> +++ b/arch/powerpc/kernel/prom_init.c 
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/prom_init.c?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93>
> @@ -1986,19 +1986,23 @@ static void __init prom_init_stdout(void)
> /* Get the full OF pathname of the stdout device */
> memset(path, 0, 256);
> call_prom("instance-to-path", 3, 1, prom.stdout, path, 255);
> - stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
> - val = cpu_to_be32(stdout_node);
> - prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
> - &val, sizeof(val));
> prom_printf("OF stdout device is: %s\n", of_stdout_device);
> prom_setprop(prom.chosen, "/chosen", "linux,stdout-path",
> path, strlen(path) + 1);
> - /* If it's a display, note it */
> - memset(type, 0, sizeof(type));
> - prom_getprop(stdout_node, "device_type", type, sizeof(type));
> - if (strcmp(type, "display") == 0)
> - prom_setprop(stdout_node, path, "linux,boot-display", NULL, 0);
> + /* instance-to-package fails on PA-Semi */
> + stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
> + if (stdout_node != PROM_ERROR) {
> + val = cpu_to_be32(stdout_node);
> + prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
> + &val, sizeof(val));
> +
> + /* If it's a display, note it */
> + memset(type, 0, sizeof(type));
> + prom_getprop(stdout_node, "device_type", type, sizeof(type));
> + if (strcmp(type, "display") == 0)
> + prom_setprop(stdout_node, path, "linux,boot-display", NULL, 0);
> + }
> }
> static int __init prom_find_machine_type(void)
>


--------------090604010403020608090404
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi All,<br>
      <br>
      Thanks a lot for your effort to solve the boot problems.
      Unfortunately, this patch doesn't work for the Nemo board. I need
      the patch created by Olof Johansson.<br>
      <br>
      diff -rupN linux-3.13/arch/powerpc/kernel/head_64.S
      linux-3.13-nemo/arch/powerpc/kernel/head_64.S<br>
      --- linux-3.13/arch/powerpc/kernel/head_64.S&nbsp;&nbsp;&nbsp; 2014-01-05
      00:12:14.000000000 +0100<br>
      +++ linux-3.13-nemo/arch/powerpc/kernel/head_64.S&nbsp;&nbsp;&nbsp; 2014-01-05
      23:06:13.001618802 +0100<br>
      @@ -69,6 +69,13 @@ _GLOBAL(__start)<br>
      &nbsp;&nbsp;&nbsp;&nbsp; /* NOP this out unconditionally */<br>
      &nbsp;BEGIN_FTR_SECTION<br>
      &nbsp;&nbsp;&nbsp;&nbsp; FIXUP_ENDIAN<br>
      +/* Hack for PWRficient platforms: Due to CFE(?) bug, the 64-bit<br>
      + * word at 0x8 needs to be set to 0. Patch it up here once we're<br>
      + * done executing it (we can be lazy and avoid invalidating<br>
      + * icache)<br>
      + */<br>
      +li&nbsp;&nbsp;&nbsp; r0,0<br>
      +std&nbsp;&nbsp;&nbsp; 0,8(0)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
      &nbsp;&nbsp;&nbsp;&nbsp; b&nbsp;&nbsp;&nbsp; .__start_initialization_multiplatform<br>
      &nbsp;END_FTR_SECTION(0, 1)<br>
      &nbsp;<br>
      Is it possible to integrate Olof's patch into the kernel sources?<br>
      <br>
      All the best,<br>
      <br>
      Christian<br>
      <br>
      Am 15.01.14 21:01, schrieb Christian Zigotzky:<br>
    </div>
    <blockquote cite="mid:52D6E928.7050307@xenosoft.de" type="cite">
      <meta content="text/html; charset=ISO-8859-1"
        http-equiv="Content-Type">
      <meta http-equiv="content-type" content="text/html;
        charset=ISO-8859-1">
      <table summary="commit info" class="commit-info">
        <tbody>
          <tr>
            <th>author</th>
            <td>Linus Torvalds <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:torvalds@linux-foundation.org">&lt;torvalds@linux-foundation.org&gt;</a></td>
            <td class="right">2014-01-13 03:59:05 (GMT)</td>
          </tr>
          <tr>
            <th>committer</th>
            <td> Linus Torvalds <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:torvalds@linux-foundation.org">&lt;torvalds@linux-foundation.org&gt;</a></td>
            <td class="right">2014-01-13 03:59:05 (GMT)</td>
          </tr>
          <tr>
            <th>commit</th>
            <td colspan="2" class="sha1"><a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93">a6da83f98267bc8ee4e34aa899169991eb0ceb93</a>
              (<a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/patch/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93">patch</a>)</td>
          </tr>
          <tr>
            <th>tree</th>
            <td colspan="2" class="sha1"><a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93">84c228e0a87475dbdb0f72621c137cce8253131b</a></td>
          </tr>
          <tr>
            <th>parent</th>
            <td colspan="2" class="sha1"><a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=061f49ec2d722f485237870f04544d8bec15a778">061f49ec2d722f485237870f04544d8bec15a778</a>
              (<a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93&amp;id2=061f49ec2d722f485237870f04544d8bec15a778">diff</a>)</td>
          </tr>
          <tr>
            <th>parent</th>
            <td colspan="2" class="sha1"><a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=10348f5976830e5d8f74e8abb04a9a057a5e8478">10348f5976830e5d8f74e8abb04a9a057a5e8478</a>
              (<a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93&amp;id2=10348f5976830e5d8f74e8abb04a9a057a5e8478">diff</a>)</td>
          </tr>
        </tbody>
      </table>
      <div class="commit-subject">Merge branch 'merge' of
        git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc<span
          class="decoration"></span></div>
      <div class="commit-msg">Pull powerpc fix from Ben Herrenschmidt:
        "Here's one regression fix for 3.13 that I would appreciate if
        you could still pull in. It was an "interesting" one to debug,
        basically it's an old bug that got somewhat "exposed" by new
        code breaking the boot on PA Semi boards (yes, it does appear
        that some people are still using these!)" * 'merge' of
        git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc:
        powerpc: Check return value of instance-to-package OF call </div>
      <div class="diffstat-header"><a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93">Diffstat</a></div>
      <table summary="diffstat" class="diffstat">
        <tbody>
          <tr>
            <td class="mode">-rw-r--r--</td>
            <td class="upd"><a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/arch/powerpc/kernel/prom_init.c?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93">arch/powerpc/kernel/prom_init.c</a></td>
            <td class="right">22</td>
            <td class="graph">
              <table summary="file diffstat" width="22%">
                <tbody>
                  <tr>
                    <td class="add" style="width: 59.1%;"><br>
                    </td>
                    <td class="rem" style="width: 40.9%;"><br>
                    </td>
                    <td class="none" style="width: 0.0%;"><br>
                    </td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
        </tbody>
      </table>
      <div class="diffstat-summary">1 files changed, 13 insertions, 9
        deletions</div>
      <table summary="diff" class="diff">
        <tbody>
          <tr>
            <td>
              <div class="head">diff --git
                a/arch/powerpc/kernel/prom_init.c
                b/arch/powerpc/kernel/prom_init.c<br>
                index cb64a6e..078145a 100644<br>
                --- a/<a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/prom_init.c?id=061f49ec2d722f485237870f04544d8bec15a778">arch/powerpc/kernel/prom_init.c</a><br>
                +++ b/<a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/prom_init.c?id=a6da83f98267bc8ee4e34aa899169991eb0ceb93">arch/powerpc/kernel/prom_init.c</a></div>
              <div class="hunk">@@ -1986,19 +1986,23 @@ static void
                __init prom_init_stdout(void)</div>
              <div class="ctx"> /* Get the full OF pathname of the
                stdout device */</div>
              <div class="ctx"> memset(path, 0, 256);</div>
              <div class="ctx"> call_prom("instance-to-path", 3, 1,
                prom.stdout, path, 255);</div>
              <div class="del">- stdout_node =
                call_prom("instance-to-package", 1, 1, prom.stdout);</div>
              <div class="del">- val = cpu_to_be32(stdout_node);</div>
              <div class="del">- prom_setprop(prom.chosen, "/chosen",
                "linux,stdout-package",</div>
              <div class="del">- &amp;val, sizeof(val));</div>
              <div class="ctx"> prom_printf("OF stdout device is: %s\n",
                of_stdout_device);</div>
              <div class="ctx"> prom_setprop(prom.chosen, "/chosen",
                "linux,stdout-path",</div>
              <div class="ctx"> path, strlen(path) + 1);</div>
              <div class="ctx"> </div>
              <div class="del">- /* If it's a display, note it */</div>
              <div class="del">- memset(type, 0, sizeof(type));</div>
              <div class="del">- prom_getprop(stdout_node,
                "device_type", type, sizeof(type));</div>
              <div class="del">- if (strcmp(type, "display") == 0)</div>
              <div class="del">- prom_setprop(stdout_node, path,
                "linux,boot-display", NULL, 0);</div>
              <div class="add">+ /* instance-to-package fails on PA-Semi
                */</div>
              <div class="add">+ stdout_node =
                call_prom("instance-to-package", 1, 1, prom.stdout);</div>
              <div class="add">+ if (stdout_node != PROM_ERROR) {</div>
              <div class="add">+ val = cpu_to_be32(stdout_node);</div>
              <div class="add">+ prom_setprop(prom.chosen, "/chosen",
                "linux,stdout-package",</div>
              <div class="add">+ &amp;val, sizeof(val));</div>
              <div class="add">+</div>
              <div class="add">+ /* If it's a display, note it */</div>
              <div class="add">+ memset(type, 0, sizeof(type));</div>
              <div class="add">+ prom_getprop(stdout_node,
                "device_type", type, sizeof(type));</div>
              <div class="add">+ if (strcmp(type, "display") == 0)</div>
              <div class="add">+ prom_setprop(stdout_node, path,
                "linux,boot-display", NULL, 0);</div>
              <div class="add">+ }</div>
              <div class="ctx"> }</div>
              <div class="ctx"> </div>
              <div class="ctx"> static int __init
                prom_find_machine_type(void)</div>
            </td>
          </tr>
        </tbody>
      </table>
    </blockquote>
    <br>
  </body>
</html>

--------------090604010403020608090404--
