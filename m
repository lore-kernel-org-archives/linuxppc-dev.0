Date: Tue, 15 Feb 2000 11:47:44 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: LinuxPPC, g++ problem with throw/catch (fwd)
Message-ID: <Pine.LNX.3.96L.1000215114646.6511B-100000@nitfol.weh.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




---------- Forwarded message ----------
Date: Tue, 15 Feb 2000 09:58:52 -0500
From: Pierre Sarrazin <sarrazip@machinasapiens.com>
To: linuxppc-user@lists.linuxppc.org
Subject: LinuxPPC, g++ problem with throw/catch


I am having a strange problem with LinuxPPC and g++ and I would like
to have a confirmation that it is not specific to my machine. A C++
exception is thrown and should be caught but is not.

If you download the archive at
  http://www3.sympatico.ca/sarrazip/bug-throw-linuxppc.tar.gz
you will have a small program that illustrates the problem. g++ must
be installed. Here is how you can try it and tell me how it behaves:

- untar the archive in some directory; this will create a subdirectory
  named 'bug-throw-linuxppc' and some files in it:
  tar xzf bug-throw-linuxppc.tar.gz

- cd bug-throw-linuxppc

- make

- ./go

This last command should display the following lines:

try: correcteurd.cpp:16
catch!
apres catch: correcteurd.cpp:18
avant new
apres new
correction
fin

If however your system has the same problem as mine, the command
should instead display the two following lines:

try: correcteurd.cpp:16
Aborted

Here is the code for main(): it is the first throw that calls
terminate(), as if there were no catch(...). ("Avant" means
before, "apres" means after, "fin" means end...)

int main(int argc, char *argv[])
{
  cerr << "try: " << __FILE__ << ":" << __LINE__ << endl;
  try { throw 1844; } catch (...) { cerr << "catch!" << endl; }
  cerr << "apres catch: " << __FILE__ << ":" << __LINE__ << endl;

  CService *leService = NULL;
  try
  {
    cerr << "avant new" << endl;
    leService = new CServiceCorrection();
    cerr << "apres new" << endl;
  }
  catch (int err)
  {
    cerr << "catch (int err): err = " << err << endl;
    return 99;
  }
  catch (...)
  {
    cerr << "catch (...)" << endl;
    return 111;
  }

  cerr << leService->NomService() << endl;

  cerr << "fin" << endl;
  return 0;
}

If I take out the statement that calls leService->NomService() at the
end of the function, then the throw 1844 is correctly caught by the
corresponding catch. I do not understand how the mere presence of the
next-to-last statement of the function can affect a statement that
comes before.

I am using LinuxPPC R5 on a PowerMac 7200/120. The problem does not
happen on a Pentium-based RedHat 5.2 or 6.0 system. The compiler is
egcs-2.91.66 19990314 (egcs-1.1.2 release) in all cases.

--
Pierre Sarrazin <sarrazip@machinasapiens.com>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
