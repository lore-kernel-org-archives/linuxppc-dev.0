Message-ID: <399D9F51.AEBE21BC@wanadoo.fr>
Date: Fri, 18 Aug 2000 22:40:49 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: The curious case of the vanishing variable
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The two commands "env" (without parameters) and "printenv" give
identical output, right? They just print a list of all the environment
variables. This has been working forever and on all kernel versions.

Not so on kernels compiled from Paul's linux-pmac-devel tree. I have an
environment variable LD_LIBRARY_PATH set to
/usr/local/lib:/usr/X11R6/lib. In the list printed by "printenv", this
shows up, in the list printed by "env", it doesn't. All other
environment variables coincide in the 2 lists.

It has been like this at least since early 2.3.99 kernels, and only with
Paul's kernels. With 2.2.X kernels and with devel kernels from the bk
tree, the 2 lists are identical.

Now this would be just a curiosity, although one completely mysterious
for me, but it goes further. If I inspect the contents of
/proc/xxx/environ, the LD_LIBRARY_PATH variable is also absent under
Paul's kernels (right now the latest 2.4.0-test7) and present (for
participating pids xxx) under other kernels.

One annoying result is that Mozilla does not run under this kernel. Due
to the wrong or non-existing LD_LIBRARY_PATH, one gets
  error in loading shared libraries: libgkgfx.so:
  cannot open shared object file: No such file or directory

Why do Paul's kernels hate and murder the LD_LIBRARY_PATH environment
variable? Any Holmes out there who can explain this mystery?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
