Date: Wed, 29 Mar 2000 21:41:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/PPC for APUS <linux-apus@sunsite.auc.dk>
Subject: Re: dmasound split
In-Reply-To: <Pine.LNX.4.05.10003262222030.3263-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10003292135280.28211-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 26 Mar 2000, Geert Uytterhoeven wrote:
>   - I forgot to move everything to drivers/sound/dmasound/. Since it's already
>     late (BTW, I hate switching to DST!), I prefer to send out this patch
>     first. Of course patches are welcomed :-)

Nah, it didn't turn out to be that difficult. Here's the script-'n-patch
(relative to `dmasound-v2'). I did some dry runs with various combinations of
config options and it seemed to look fine.

Note that I created the global switch CONFIG_DMASOUND, set in arch-specific
config code, to avoid having to clutter drivers/sound/Makefile too much. Anyone
with a better solution?

Thanks for testing and reporting back to the list!

mkdir drivers/sound/dmasound
mv drivers/sound/dmasound.h drivers/sound/dmasound_*.c drivers/sound/dmasound

diff -urN dmasound-v2/arch/m68k/config.in dmasound-v3-beta/arch/m68k/config.in
--- dmasound-v2/arch/m68k/config.in	Sun Mar 26 20:30:21 2000
+++ dmasound-v3-beta/arch/m68k/config.in	Wed Mar 29 21:01:29 2000
@@ -492,6 +492,17 @@
    if [ "$CONFIG_Q40" = "y" ]; then
       dep_tristate '  Q40 sound support' CONFIG_DMASOUND_Q40 $CONFIG_SOUND
    fi
+   if [ "$CONFIG_DMASOUND_PAULA" = "y" -o \
+        "$CONFIG_DMASOUND_ATARI" = "y" -o \
+	"$CONFIG_DMASOUND_Q40" = "y" ]; then
+      define_tristate CONFIG_DMASOUND y
+   else
+      if [ "$CONFIG_DMASOUND_PAULA" = "m" -o \
+	   "$CONFIG_DMASOUND_ATARI" = "m" -o \
+	   "$CONFIG_DMASOUND_Q40" = "m" ]; then
+	 define_tristate CONFIG_DMASOUND m
+      fi
+   fi
 fi
 endmenu

diff -urN dmasound-v2/arch/ppc/config.in dmasound-v3-beta/arch/ppc/config.in
--- dmasound-v2/arch/ppc/config.in	Sun Mar 26 20:30:11 2000
+++ dmasound-v3-beta/arch/ppc/config.in	Wed Mar 29 21:02:56 2000
@@ -260,6 +260,15 @@
   if [ "$CONFIG_ALL_PPC" = "y" ]; then
     dep_tristate 'PowerMac DMA sound support' CONFIG_DMASOUND_AWACS $CONFIG_SOUND
   fi
+  if [ "$CONFIG_DMASOUND_PAULA" = "y" -o \
+       "$CONFIG_DMASOUND_AWACS" = "y" ]; then
+    define_tristate CONFIG_DMASOUND y
+  else
+    if [ "$CONFIG_DMASOUND_PAULA" = "m" -o \
+	 "$CONFIG_DMASOUND_AWACS" = "m" ]; then
+       define_tristate CONFIG_DMASOUND m
+    fi
+  fi
   source drivers/sound/Config.in
 fi

diff -urN dmasound-v2/drivers/sound/Makefile dmasound-v3-beta/drivers/sound/Makefile
--- dmasound-v2/drivers/sound/Makefile	Sun Mar 26 20:30:21 2000
+++ dmasound-v3-beta/drivers/sound/Makefile	Wed Mar 29 21:23:50 2000
@@ -19,7 +19,7 @@
 export-objs	:=  ad1848.o audio_syms.o midi_syms.o mpu401.o \
 		    msnd.o opl3.o sb_common.o sequencer_syms.o \
 		    sound_core.o sound_syms.o uart401.o	\
-		    nm256_audio.o ac97.o ac97_codec.o dmasound_core.o
+		    nm256_audio.o ac97.o ac97_codec.o



@@ -80,13 +80,15 @@
 obj-$(CONFIG_SOUND_MAESTRO)	+= maestro.o
 obj-$(CONFIG_SOUND_TRIDENT)	+= trident.o ac97_codec.o

-
-# Dmasound drivers
-
-obj-$(CONFIG_DMASOUND_ATARI)  += dmasound_core.o dmasound_atari.o
-obj-$(CONFIG_DMASOUND_AWACS)  += dmasound_core.o dmasound_awacs.o
-obj-$(CONFIG_DMASOUND_PAULA)  += dmasound_core.o dmasound_paula.o
-obj-$(CONFIG_DMASOUND_Q40)    += dmasound_core.o dmasound_q40.o
+ifeq ($(CONFIG_DMASOUND),y)
+  SUB_DIRS += dmasound
+  MOD_SUB_DIRS += dmasound
+  obj-y += dmasound/dmasound.o
+else
+  ifeq ($(CONFIG_DMASOUND),m)
+    MOD_SUB_DIRS += dmasound
+  endif
+endif


 # Declare multi-part drivers.
diff -urN dmasound-v2/drivers/sound/dmasound/Makefile dmasound-v3-beta/drivers/sound/dmasound/Makefile
--- dmasound-v2/drivers/sound/dmasound/Makefile	Thu Jan  1 01:00:00 1970
+++ dmasound-v3-beta/drivers/sound/dmasound/Makefile	Wed Mar 29 21:29:50 2000
@@ -0,0 +1,38 @@
+#
+# Makefile for the DMA sound driver
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definitions are now in the main makefile...
+
+O_TARGET    :=
+O_OBJS      :=
+OX_OBJS     :=
+M_OBJS      :=
+MX_OBJS     :=
+
+export-objs := dmasound_core.o
+
+obj-$(CONFIG_DMASOUND_ATARI)  += dmasound_core.o dmasound_atari.o
+obj-$(CONFIG_DMASOUND_AWACS)  += dmasound_core.o dmasound_awacs.o
+obj-$(CONFIG_DMASOUND_PAULA)  += dmasound_core.o dmasound_paula.o
+obj-$(CONFIG_DMASOUND_Q40)    += dmasound_core.o dmasound_q40.o
+
+# Files that are both resident and modular: remove from modular.
+
+obj-m       := $(filter-out $(obj-y), $(obj-m))
+
+# Translate to Rules.make lists.
+
+O_OBJS      := $(filter-out $(export-objs), $(obj-y))
+OX_OBJS     := $(filter     $(export-objs), $(obj-y))
+M_OBJS      := $(sort $(filter-out $(export-objs), $(obj-m)))
+MX_OBJS     := $(sort $(filter     $(export-objs), $(obj-m)))
+
+ifeq ($(CONFIG_DMASOUND),y)
+  O_TARGET = dmasound.o
+endif
+
+include $(TOPDIR)/Rules.make


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
