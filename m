From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15367.28631.770924.535793@argo.ozlabs.ibm.com>
Date: Fri, 30 Nov 2001 22:39:03 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: platform.h
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here is the code that Keith sent me to create platform.h and
platform_serial.h.  It took me a while to understand it too. :)
To make this work we need to make archdep and include/config/MARKER
depend on platformlinks.

Paul.

# h_files:	List of architecture specific platform .h files.
# suffices:	The standard set of suffices to generate.
# dir:		The directory to hold the generated files.
# platform:     The platform that has been selected.  It is extracted by looking
#               for the magic string in all h_files, converting the filename and
#               config from each magic string to a sed command, using that sed
#               command to find matching options in .config then printing the
#               corresponding platform name.  platform must contain exactly one
#               string.

# After the platform has been identified, temporary versions of the target files
# are created from the suffix list, making empty files if necessary.  The result
# is compared against the existing files which are only updated if anything has
# changed.

platformlinks:
	@set -e; \
	h_files="$(wildcard include/asm-$(ARCH)/platforms/*.h)"; \
	suffices=".h _serial.h"; \
	dir="arch/$(ARCH)"; \
	platform=`grep "^/\\* Copy to platform.h if CONFIG_[^ ]*=y \\*/\$$" $$h_files | \
		  (echo "/^CONFIG/{h;"; \
		    sed -e "s%.*/\\([^/.]*\\)\\.h:.*\\(CONFIG_[^ ]*=y\\).*%g; s/^\\2\$$/\\1/p;%"; \
		    echo "}") | \
		  sed -nf - .config`; \
	platform=`echo $$platform`; \
	if [ -z "$$platform" ]; then echo "No $(ARCH) platform found in .config" >&2; /bin/false; fi; \
	if expr "$$platform" : ".* " > /dev/null; then echo "Multiple $(ARCH) platforms ($$platform) found in .config" >&2; /bin/false; fi; \
	for i in $$suffices; do \
	  output=$$dir/platform$$i; \
	  tmp_output=$$dir/.tmp_platform$$i; \
	  input=`echo " $$h_files " | sed -ne "\\:/$$platform$$i :s%.* \\([^ ]*/$$platform$$i\\) .*%\\1%p"`; \
	  rm -f $$tmp_output; \
	  [ -z "$$input" ] && touch $$tmp_output || cp $$input $$tmp_output; \
	  cmp -s $$tmp_output $$output || (echo "Updating $$output for $$platform"; mv $$tmp_output $$output); \
	  rm -f $$tmp_output; \
	done;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
